module CreateSubdirectories
  def scholarship_folders
    Dir.mkdir("xml")
    Dir.mkdir("excel")
    Dir.mkdir("pdf")
    self
  end
  def trove_folders
    Dir.mkdir("xml")
    Dir.mkdir("excel")
    Dir.mkdir("tif")
    self
  end
  def springer_folders
    Dir.mkdir("xml")
    Dir.mkdir("xml/springer_original_xml")
    Dir.mkdir("pdf")
    Dir.mkdir("zip")
    Dir.mkdir("springer")
    self
  end 
  def proquest_folders
    Dir.mkdir("xml")
    Dir.mkdir("pdf")
    Dir.mkdir("zip")
    self
  end 
end