require "spec_helper"

describe OJXV::JatsFile do
  describe "initialization" do
    it "should error if file not found" do
      _ { OJXV::JatsFile.new(fixture("non-existent")) }.must_raise ::OJXV::FileNotFound
    end

    it "should set filepath" do
      jats_file = OJXV::JatsFile.new(fixture("paper.jats"))
      _(jats_file.filepath).must_equal fixture("paper.jats")
    end
  end

  it "should define supported schema versions" do
    supported_versions = OJXV::JatsFile.supported_schema_versions
    _(supported_versions).must_equal ["1.1", "1.1d1", "1.1d2", "1.1d3", "1.2", "1.2d1", "1.2d2", "1.3d1", "1.3d2", "1.3"]
  end

  describe "valid_jats?" do
    it "should be true for valid files" do
      jats_file = OJXV::JatsFile.new(fixture("paper.jats"))
      _(jats_file.valid_jats?).must_equal true
    end

    it "should empty errors if valid" do
      jats_file = OJXV::JatsFile.new(fixture("paper.jats"))
      _(jats_file.valid_jats?).must_equal true
      _(jats_file.errors).must_be :empty?
    end

    it "should be false for invalid files" do
      jats_file = OJXV::JatsFile.new(fixture("paper.jats.invalid"))
      _(jats_file.valid_jats?).must_equal false
    end

    it "should set errors if invalid" do
      jats_file = OJXV::JatsFile.new(fixture("paper.jats.invalid"))
      _(jats_file.valid_jats?).must_equal false
      _(jats_file.errors.empty?).must_equal false
    end

    it "should error if file does not declare a DTD" do
      jats_file = OJXV::JatsFile.new(fixture("paper.invalid"))
      _ { jats_file.valid_jats? }.must_raise ::OJXV::NoDTD
    end

    it "should error if invalid schema version" do
      jats_file = OJXV::JatsFile.new(fixture("paper.jats"))
      _ { jats_file.valid_jats?("100.X.33") }.must_raise ::OJXV::UnsupportedJATSSchemaVersion
    end
  end
end