class MainController < ApplicationController
  def index
    @ip_address = Variable.where(name: 'ip_address').first_or_initialize.value
    @google_voice = Variable.where(name: 'google_voice').first_or_initialize.value
    @long_name = Variable.where(name: 'long_name').first_or_initialize.value
    @meshtastic_cli_path = Variable.where(name: 'meshtastic_cli_path').first_or_initialize.value
    @max_text_length = Variable.where(name: 'max_text_length').first_or_initialize.value
    @channels = Variable.where(name: 'channels').first_or_initialize.value.split("\n") rescue []
    Thread.new {
      sleep 1;
      $message_broadcaster.broadcast(message: 'No IP Address is defined.') if @ip_address.blank?
      $message_broadcaster.broadcast(message: 'No Google Voice is defined.') if @google_voice.blank?
      $message_broadcaster.broadcast(message: 'No Long Name is defined.') if @long_name.blank?
      $message_broadcaster.broadcast(message: 'No Meshtastic CLI path is defined.') if @meshtastic_cli_path.blank?
      $message_broadcaster.broadcast(message: 'No Max Text Length is defined.') if @max_text_length.blank?
      $message_broadcaster.broadcast(message: 'No Channels are defined.') if @channels.blank?
    }
  end

  def settings
    @ip_address = Variable.where(name: 'ip_address').first_or_initialize
    @google_voice = Variable.where(name: 'google_voice').first_or_initialize
    @long_name = Variable.where(name: 'long_name').first_or_initialize
    @meshtastic_cli_path = Variable.where(name: 'meshtastic_cli_path').first_or_initialize
    @max_text_length = Variable.where(name: 'max_text_length').first_or_initialize
    @channels = Variable.where(name: 'channels').first_or_initialize
    if request.post?
      if params.include?(:google_voice)
        @google_voice.value = params[:google_voice]
        @google_voice.save
      end
      if params.include?(:ip_address)
        @ip_address.value = params[:ip_address]
        @ip_address.save
      end
      if params.include?(:long_name)
        @long_name.value = params[:long_name]
        @long_name.save
      end
      if params.include?(:meshtastic_cli_path)
        @meshtastic_cli_path.value = params[:meshtastic_cli_path]
        @meshtastic_cli_path.save
      end
      if params.include?(:max_text_length)
        @max_text_length.value = params[:max_text_length]
        @max_text_length.save
      end
      if params.include?(:channels)
        @channels.value = params[:channels]
        @channels.save
      end
    end
  end

  def upload
    path = 'public/input.mp3'
    File.write(path, params[:files].read, mode: 'wb')
    text = VoiceToText.new(path).text
    if text.blank?
      $message_broadcaster.broadcast(message: 'No voice was detected.')
    else
      $message_receiver.hold = true
      $message_receiver.kill
      long_name = Variable.where(name: 'long_name').first_or_initialize.value
      node = Node.new(long_name: long_name)
      $message_broadcaster.broadcast(ch_index: params[:ch_index], message: text, node: node)
      $message_transmitter.transmit(ch_index: params[:ch_index], message: text)
      $message_receiver.hold = false
    end
    render json: {data: {text: text}}.to_json
  end
end