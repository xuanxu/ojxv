require "spec_helper"

describe OJXV::CrossrefMetadataFile do
  describe "initialization" do
    it "should error if file not found" do
      _ { OJXV::CrossrefMetadataFile.new(fixture("non-existent")) }.must_raise ::OJXV::FileNotFound
    end

    it "should set file" do
      crossref_file = OJXV::CrossrefMetadataFile.new(fixture("paper.crossref"))
      _(crossref_file.file.path).must_equal File.open(fixture("paper.crossref")).path
    end
  end

  it "should define supported schema versions" do
    supported_versions = OJXV::CrossrefMetadataFile.supported_schema_versions
    _(supported_versions).must_equal ["4.8.0", "4.8.1", "5.1.0", "5.2.0", "5.3.0", "5.3.1"]
  end

  describe "valid_crossref?" do
    it "should be true for valid files" do
      crossref_file = OJXV::CrossrefMetadataFile.new(fixture("paper.crossref"))
      _(crossref_file.valid_crossref?).must_equal true
    end

    it "should empty errors if valid" do
      crossref_file = OJXV::CrossrefMetadataFile.new(fixture("paper.crossref"))
      _(crossref_file.valid_crossref?).must_equal true
      _(crossref_file.errors).must_be :empty?
    end

    it "should be false for invalid files" do
      crossref_file = OJXV::CrossrefMetadataFile.new(fixture("paper.invalid"))
      _(crossref_file.valid_crossref?).must_equal false
    end

    it "should set errors if invalid" do
      crossref_file = OJXV::CrossrefMetadataFile.new(fixture("paper.invalid"))
      _(crossref_file.valid_crossref?).must_equal false
      _(crossref_file.errors.empty?).must_equal false
    end

    it "should error if invalid schema version" do
      crossref_file = OJXV::CrossrefMetadataFile.new(fixture("paper.crossref"))
      _ { crossref_file.valid_crossref?("100.X.33") }.must_raise ::OJXV::UnsupportedCrossrefSchemaVersion
    end
  end
end
