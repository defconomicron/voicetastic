class LiElement
  def initialize(str)
    @str = str
  end

  def render
    @str = "<li class=\"#{($i||=0) % 2==0 ? :even : :odd}\">#{@str}</li>"
    $i += 1
    @str
  end
end