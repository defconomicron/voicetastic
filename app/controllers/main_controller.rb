class MainController < ApplicationController
  def index
    @channels = $settings['channels']
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
      node = Node.new(long_name: $settings['node']['long_name'])
      $message_broadcaster.broadcast(ch_index: params[:ch_index], message: text, node: node)
      $message_transmitter.transmit(ch_index: params[:ch_index], message: text)
      $message_receiver.hold = false
    end
    render json: {data: {text: text}}.to_json
  end
end