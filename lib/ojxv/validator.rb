require 'nokogiri'

module OJXV
  class Validator

    # VALIDATING JATS against declared DTD
    # DTD schemas found at https://github.com/JATS4R/jats-dtds
    # run inside the JATS-DTD 1.2 dir or reference the dtd there.

    def valid_jats?(jats_file)
      doc = Nokogiri::XML(File.open(jats_file)) do |config|
        config.dtdvalid
      end

      errors = doc.external_subset.validate(doc)
      errors.empty?
    end


    # VALIDATING CROSSREF against the XSD
    # Download Crossref bundle from Gitlab: https://gitlab.com/crossref/schema/-/releases
    # Docs: https://www.crossref.org/documentation/schema-library/metadata-deposit-schema-4-4-2/
    # XSD schema: min version 4.4.2

    def valid_crossref?(crossref_file)
      xsd = Nokogiri::XML::Schema(File.open('crossref-schema/schemas/crossref5.3.1.xsd'))
      doc = Nokogiri::XML(File.read(crossref_file))

      errors = xsd.validate(doc)
      errors.empty?
    end

  end
end
