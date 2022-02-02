module Common
  def fixture(file_name)
    File.join(File.dirname(__FILE__), "fixtures", file_name)
  end
end