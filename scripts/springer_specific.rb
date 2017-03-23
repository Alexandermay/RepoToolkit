module Springer_Issues
  def rename_springer_xml
    FileUtils.mv Dir.glob('**/*.Meta'),'xml'
    Dir.chdir("xml")
    Dir.entries('.').each do |entry|
    puts entry
    if m = entry.match('\d.*\.xml\.Meta')
    File.rename(entry, entry.gsub(".Meta", ""))
    puts "changed!"
    end
    end
    self
 end
 def package_springer_up
    Dir.chdir("..")
    FileUtils.mv Dir.glob('**/*.pdf'),'pdf'
    Dir.chdir("pdf") 
    Dir.entries('.').each do |entry|
    puts entry
    end
    Dir.chdir("..")
    FileUtils.mv Dir.glob('**/*.zip'),'zip'
    Dir.chdir("zip") 
    Dir.entries('.').each do |entry|
    puts entry
    end
    Dir.chdir("..")
    FileUtils.mv Dir.glob('JOU*'),'springer'
    Dir.chdir("springer") 
    Dir.entries('.').each do |entry|
    puts entry
  end
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
end