require_relative "ojxv/crossref_metadata_file"
require_relative "ojxv/version"

module OJXV
  class Error < StandardError; end
  class FileNotFound < Error; end
  class XMLParsingError < Error; end
  class UnsupportedCrossrefSchemaVersion < Error; end
end
