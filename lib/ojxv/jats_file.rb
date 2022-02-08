require 'nokogiri'
require 'securerandom'
require 'fileutils'

module OJXV
  # VALIDATING JATS against DTD
  # DTD schemas from https://jats.nlm.nih.gov/archiving/1.3/dtd.html
  class JatsFile

    attr_accessor :errors
    attr_reader :filepath

    def initialize(path)
      @errors = nil
      raise ::OJXV::FileNotFound, "Can't find file: #{path}" unless File.exist?(path)
      @filepath = path
    end

    def valid_jats?(schema_version="1.3")
      @errors = nil
      FileUtils.mkdir_p(local_path)

      FileUtils.cp_r schema_files_path(schema_version), local_path
      FileUtils.cp @filepath, local_path

      new_filepath = File.join(local_path, File.basename(@filepath))

      doc = Nokogiri::XML(File.open(new_filepath)) do |config|
        config.dtdload.dtdvalid
      end

      raise(NoDTD, "File has no DTD declaration") if doc.external_subset.nil?

      @errors = doc.external_subset.validate(doc)
      @errors.empty?

    rescue Nokogiri::XML::SyntaxError => e
      raise ::OJXV::XMLParsingError, e.message
    ensure
      cleanup
    end

    def self.supported_schema_versions
      ["1.1", "1.1d1", "1.1d2", "1.1d3", "1.2", "1.2d1", "1.2d2", "1.3d1", "1.3"]
    end

    private

      def schema_files_path(schema_version)
        unless JatsFile.supported_schema_versions.include?(schema_version)
          raise ::OJXV::UnsupportedJATSSchemaVersion, "Unsupported JATS schema version: #{schema_version}"
        end

        File.join(File.dirname(__FILE__), "schemas", "jats", schema_version.to_s, ".")
      end

      def local_path
        @local_path ||= "tmp-ojxv-jats-#{SecureRandom.hex(3)}"
      end

      def cleanup
        FileUtils.rm_rf(local_path) if Dir.exist?(local_path)
      end
  end
end