module Bgg
  module Result
    attr_reader :xml

    private

    def xpath_value_int(path, xml = @xml)
      value = xpath_value path, xml
      if value
        value.to_i
      end
    end

    def xpath_value_float(path, xml = @xml)
      value = xpath_value path, xml
      if value
        value.to_f
      end
    end

    def xpath_value_boolean(path, xml = @xml)
      value = xpath_value path, xml
      if value
        value == '1'
      end
    end

    def xpath_value(path, xml = @xml)
      node = xml.at_xpath(path)
      if node.instance_of? Nokogiri::XML::Attr
        node.value
      elsif node.instance_of? Nokogiri::XML::Element
        node.text
      end
    end

  end
end
