class MessageProcessor
  def initialize
  end

  def process
    Thread.new {
      $message_receiver.try(:receive) do |message|
        node = number_to_node(message['from'])
        case message['portnum']
          when 'TEXT_MESSAGE_APP'
            broadcast(message: message, node: node)
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

    def broadcast(message: {}, node: nil)
      log message, :yellow
      @time ||= 0
      if @time < message['time'].to_i
        $message_broadcaster.broadcast(ch_index: message['channel'], message: message['payload'], node: node, voice: true)
        @time = message['time'].to_i
      end
    end

    def number_to_node(number)
      Node.where(number: number).first_or_initialize
    end

    def log(text, color = nil)
      $log_it.log "MessageProcessor: #{text}", color
    end
end