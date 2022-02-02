require 'nokogiri'

module OJXV
  # VALIDATING CROSSREF against the XSD
  # Crossref bundle v0.3.1 from https://gitlab.com/crossref/schema/-/releases
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
      doc = Nokogiri::XML(file.read)

      @errors = xsd.validate(doc)
      @errors.empty?

    rescue Nokogiri::XML::SyntaxError => e
      raise ::OJXV::XMLParsingError, e.message
    end

    def self.supported_schema_versions
      ["4.8.0", "4.8.1", "5.1.0", "5.2.0", "5.3.0", "5.3.1"]
    end

    private

      def schema(crossref_version)
        schema_path = File.join(File.dirname(__FILE__), "schemas", "crossref", "crossref#{crossref_version}.xsd")

        unless File.exist?(schema_path) && CrossrefMetadataFile.supported_schema_versions.include?(crossref_version)
          raise ::OJXV::UnsupportedCrossrefSchemaVersion, "Unsupported Crossref schema version: #{crossref_version}"
        end

        File.open(schema_path)
      end
  end
end