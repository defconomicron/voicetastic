class MessageProcessor
  def initialize
  end

  def process
    Thread.new {
      @time = 0
      $message_receiver.try(:receive) do |message|
        node = Node.where(number: message['from']).first_or_initialize
        case message['portnum']
          when 'TEXT_MESSAGE_APP'
            log message, :yellow
            if @time < message['time'].to_i
              puts "#{message}".colorize(:yellow)
              $message_broadcaster.broadcast(ch_index: message['channel'], message: message['payload'], node: node, voice: true)
              @time = message['time'].to_i
            end
          when 'POSITION_APP'
            node.position_snapshot = message.to_json
          when 'TELEMETRY_APP'
            node.telemetry_snapshot = message.to_json
          when 'NODEINFO_APP'
            node.nodeinfo_snapshot = message.to_json
        end
        node.save
      end
    }
    self
  end

  private

    def log(text, color = nil)
      $log_it.log "MessageProcessor: #{text}", color
    end
end