class MainController < ApplicationController
  def index
    @channels = SETTINGS['channels']
  end

  def upload
    path = 'public/input.mp3'
    File.write(path, params[:files].read, mode: 'wb')
    text = VoiceToText.new(path).text
    if text.blank?
      MESSAGE_BROADCASTER.broadcast(message: 'No voice was detected.')
    else
      MESSAGE_RECEIVER.hold = true
      MESSAGE_RECEIVER.kill
      node = Node.new(long_name: SETTINGS['node']['long_name'])
      MESSAGE_BROADCASTER.broadcast(ch_index: params[:ch_index], message: text, node: node)
      MESSAGE_TRANSMITTER.transmit(ch_index: params[:ch_index], message: text)
      MESSAGE_RECEIVER.hold = false
    end
    render json: {data: {text: text}}.to_json
  end
end