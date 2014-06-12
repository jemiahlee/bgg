module Bgg
  module Result

    attr_reader :request, :xml

    def initialize(xml, request)
      @xml = xml
      @request = request
    end

    def request_params
      @request.params
    end

    private

    def xpath_value_int(path, xml = @xml)
      value = xpath_value path, xml
      if value
        Integer(value) rescue nil
      end
    end

    def xpath_value_float(path, xml = @xml)
      value = xpath_value path, xml
      if value
        Float(value) rescue nil
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
