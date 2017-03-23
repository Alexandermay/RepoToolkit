module CleanUp
  def clean_excel
    Dir.chdir("xml")
    FileUtils.rm('firstTransform.xml')
    FileUtils.rm('workWithThis.xml')
    FileUtils.rm('collection.xml')
    self
  end 
  
  def clean_proquest
    Dir.chdir("xml")
    FileUtils.rm('collection.xml')
    self
  end 
end