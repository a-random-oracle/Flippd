require_relative 'text-box'

module Questions
  class TextArea < TextBox
    def to_html
      %(<textarea name="q-#{@index}"></textarea>)
    end

    def self.schema
      parent = super
      parent[:properties][:type][:pattern] = "^text-area$"
      parent
    end
  end
end
