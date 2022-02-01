require 'nokogiri'

module OJXV
  class FileNotFound < StandardError; end
  class XMLParsingError < StandardError; end
  class UnsupportedCrossrefSchemaVersion < StandardError; end

  class CrossrefMetadataFile

    attr_accessor :errors
    attr_accessor :file

    def initialize(filepath)
      @errors = nil
      if File.exist?(filepath)
        @file = File.open(filepath)
      else
        raise ::OJXV::FileNotFound, "Can't find file: #{filepath}"
      end
    end

    def valid_crossref?(crossref_version="5.3.1")
      @errors = nil

      xsd = Nokogiri::XML::Schema(schema(crossref_version))
      doc = Nokogiri::XML(File.read(file))

      @errors = xsd.validate(doc)
      @errors.empty?
    rescue Nokogiri::XML::SyntaxError => e
      raise XMLParsingError, e.message
    end

    def self.supported_schema_versions
      ["4.8.0", "4.8.1", "5.1.0", "5.2.0", "5.3.0", "5.3.1"]
    end

    private

      def schema(crossref_version)
        schema_path = File.join(File.dirname(__FILE__), "schemas", "crossref", "crossref#{crossref_version}.xsd")

        raise ::OJXV::UnsupportedCrossrefSchemaVersion, "Unsupported Crossref schema version: #{crossref_version}" unless File.exist?(schema_path)

        File.open(schema_path)
      end
  end
end