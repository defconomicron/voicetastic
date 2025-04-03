class MessageBroadcaster
  def initialize
  end

  def broadcast(ch_index: nil, message: nil, node: nil, voice: nil)
    channel_name = ch_index.present? ? $settings['channels'][ch_index.to_i] : nil
    tokens1 = []
    tokens1 << "[#{channel_name}]" if channel_name.present?
    tokens1 << "&lt;#{node.nil? ? 'SYSTEM' : node.name}&gt;"
    tokens2 = []
    tokens2 << message
    tokens2 << TextToVoice.new(message).voice if voice
    html = LiElement.new(tokens1.join(' ') << ' ' << tokens2.join('<br />')).render
    Message.new.broadcast_prepend_to('Messages', target: 'messages', html: html)
    self
  end
end