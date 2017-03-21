module PackageBinaries
def gobble_xml
    FileUtils.mv Dir.glob('**/*.xml'),'xml'
      Dir.chdir("xml") 
      Dir.entries('.').each do |entry|
      puts entry
    end
    self
end
def gobble_subjects
  Dir.chdir("..")
    FileUtils.mv Dir.glob('subjects.txt'),'xml'
      Dir.chdir("xml") 
      Dir.entries('.').each do |entry|
      puts entry
    end
    self
end
  def gobble_excel
    Dir.chdir("..")
      FileUtils.mv Dir.glob('**/*.xlsx'),'excel'
        Dir.chdir("excel") 
        Dir.entries('.').each do |entry|
        puts entry
      end
      self
  end
  def gobble_pdf
    Dir.chdir("..")
      FileUtils.mv Dir.glob('**/*.pdf'),'pdf'
        Dir.chdir("pdf") 
        Dir.entries('.').each do |entry|
        puts entry
    end
    self
  end
  def gobble_tif
    Dir.chdir("..")
      FileUtils.mv Dir.glob('**/*.tif'),'tif'
        Dir.chdir("tif") 
        Dir.entries('.').each do |entry|
        puts entry
    end
    self
  end
  def gobble_springer_xml
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
  def gobble_zip
    Dir.chdir("..")
      FileUtils.mv Dir.glob('**/*.zip'),'zip'
        Dir.chdir("zip") 
        Dir.entries('.').each do |entry|
        puts entry
    end
    self
  end
end