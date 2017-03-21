module CleanUp
  def clean_excel
    Dir.chdir("../xml")
    FileUtils.rm('firstTransform.xml')
    FileUtils.rm('workWithThis.xml')
    FileUtils.rm('collection.xml')
    self
  end 
  def gobble_springer
   Dir.chdir("..")
   FileUtils.mv Dir.glob('JOU*'),'springer'
   Dir.chdir("springer") 
   Dir.entries('.').each do |entry|
   puts entry
   end 
   self
  end
  def clean_springer
    Dir.chdir("..")
    FileUtils.remove_entry 'springer'
    Dir.chdir("xml")
    FileUtils.rm('collection.xml')
    FileUtils.mv Dir.glob('[1-9]*.xml'),'springer_original_xml'
    Dir.chdir("springer_original_xml") 
    Dir.entries('.').each do |entry|
    puts entry
    end 
    self
  end
  def clean_proquest
    Dir.chdir("../xml")
    FileUtils.rm('collection.xml')
    self
  end 
end