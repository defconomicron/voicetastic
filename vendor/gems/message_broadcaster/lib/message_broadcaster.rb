class MessageBroadcaster
  def initialize
  end

  def broadcast(ch_index: nil, message: nil, node: nil, voice: nil)
    str = [ch_index_to_channel_name(ch_index), node_to_node_name(node)].join(' ') << ' ' <<
          [message, text_to_voice(message, voice)].join('<br />')
    Message.new.broadcast_prepend_to('Messages', target: 'messages', html: str_to_li_element(str))
    self
  end

  def ch_index_to_channel_name(ch_index)
    str = ch_index.present? ? channels[ch_index.to_i] : nil
    "[#{str}]" if str.present?
  end

  def node_to_node_name(node)
    "&lt;#{node.nil? ? 'SYSTEM' : node.name}&gt;"
  end

  def text_to_voice(message, voice)
    TextToVoice.new(message).voice if voice
  end

  def str_to_li_element(str)
    LiElement.new("#{str}").render
  end

  def channels
    Variable.where(name: 'channels').first_or_initialize.value.split("\n") rescue []
  end
end
