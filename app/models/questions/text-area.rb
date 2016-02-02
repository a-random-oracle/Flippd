require_relative 'text-box'

module Questions
  class TextArea < TextBox
    def to_html
      %(<textarea name="q-#{@index}"></textarea>)
    end
  end
end
