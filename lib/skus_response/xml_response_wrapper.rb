module OnOff
  module API
    class XmlResponseWrapper
      attr_accessor :response

      def initialize(response)
        @response = response
      end

      def to_xml
        @response
      end
    end
  end
end