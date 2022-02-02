require_relative "ojxv/crossref_metadata_file"
require_relative "ojxv/jats_file"
require_relative "ojxv/version"

module OJXV
  class Error < StandardError; end
  class FileNotFound < Error; end
  class XMLParsingError < Error; end
  class UnsupportedCrossrefSchemaVersion < Error; end
  class NoDTD < Error; end
  class UnsupportedJATSSchemaVersion < Error; end
end
