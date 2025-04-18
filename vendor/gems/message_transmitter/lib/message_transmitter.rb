class MessageTransmitter
  def initialize
  end

  def transmit(ch_index: nil, message: nil)
    ensure_ch_index(ch_index)
    hold_message_receiver
    kill_message_receiver
    @retries = 2
    begin
      send_text(ch_index, message)
    rescue Exception => e
      retry if retry?(e)
    end
    release_message_receiver
    self
  end

  private

    def retry?(e)
      log "#{e} #{e.backtrace}", :red
      if @retries > 0
        @retries -= 1
        log "Retrying [remaining: #{@retries}]", :yellow
      end
      @retries > 0
    end

    def send_text(ch_index, message)
      execute_cmd("#{meshtastic_cli_path} --host #{host} --ch-index #{ch_index} --no-time --ack --sendtext \"#{sanitize(message)}\"")
    end

    def ensure_ch_index(ch_index)
      raise Exception.new('ch_index not defined') if ch_index.blank?
    end

    def hold_message_receiver
      log 'Placing MessageReceiver on hold...'
      $message_receiver.hold = true
    end

    def kill_message_receiver
      begin
        log 'Killing MessageReceiver...'
        $message_receiver.kill
      rescue
        log 'Attempting to kill MessageReceiver again...'
        retry
      end
    end

    def release_message_receiver
      log 'Releasing MessageReceiver hold...'
      $message_receiver.hold = false
    end

    def execute_cmd(cmd)
      log cmd, :yellow
      response = []
      begin
        PTY.spawn(cmd) do |stdout, stdin, pid|
          stdout.each do |line|
            log line
            response << line
          end
        end
      rescue Exception => e
        log "#{e}"
        response << "#{e}"
      end
      raise Exception.new(response.join(' ')) if error?(response.join(' '))
      response
    end

    def error?(str)
      str =~ /timed out/i ||
      str =~ /error connecting/i ||
      str =~ /connection reset/i ||
      str =~ /broken pipe/i
    end

    def log(text, color = nil)
      $log_it.log "MessageTransmitter: #{text}", color
    end

    def sanitize(str)
      "#{str}".gsub('"',"'").gsub("\n",'').gsub("\r",'')[0..(max_text_length-1)]
    end

    def max_text_length
      Variable.where(name: 'max_text_length').first_or_initialize.value.to_i
    end
  
    def meshtastic_cli_path
      Variable.where(name: 'meshtastic_cli_path').first_or_initialize.value
    end
  
    def host
      Variable.where(name: 'ip_address').first_or_initialize.value
    end
end