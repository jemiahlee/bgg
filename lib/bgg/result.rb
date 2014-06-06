module Bgg
  module Result
    attr_reader :xml

    private

    def xpath_value_int(path)
      value = xpath_value path
      if value
        value.to_i
      end
    end

    def xpath_value_boolean(path)
      value = xpath_value path
      if value
        value == '1'
      end
    end

    def xpath_value(path)
      node = self.xml.at_xpath(path)
      if node.instance_of? Nokogiri::XML::Attr
        node.value
      elsif node.instance_of? Nokogiri::XML::Element
        node.text
      end
    end

  end
end
