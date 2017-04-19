module PackageBinaries
  require './set_directories.rb'
  include SetDirectories
def package_it_up
Dir.chdir(@copy_of_directory)
if !Dir.glob('*.xml').empty?
    FileUtils.mv Dir.glob('**/*.xml'),'xml'
    Dir.chdir("xml") 
    Dir.entries('.').each do |entry|
    puts entry
end
end
Dir.chdir(@copy_of_directory)
if !Dir.glob('*.txt').empty?
    FileUtils.mv Dir.glob('subjects.txt'),'xml'
    Dir.chdir("xml") 
    Dir.entries('.').each do |entry|
    puts entry
end
end
Dir.chdir(@copy_of_directory)
if !Dir.glob('*.xlsx').empty?
    FileUtils.mv Dir.glob('**/*.xlsx'),'excel'
    Dir.chdir("excel") 
    Dir.entries('.').each do |entry|
    puts entry
end
end
Dir.chdir(@copy_of_directory)
if !Dir.glob('**/*.pdf').empty?
    FileUtils.mv Dir.glob('**/*.pdf'),'pdf'
    Dir.chdir("pdf") 
    Dir.entries('.').each do |entry|
    puts entry
end
end
Dir.chdir(@copy_of_directory)
if !Dir.glob('*.tif').empty?
    FileUtils.mv Dir.glob('**/*.tif'),'tif'
    Dir.chdir("tif") 
    Dir.entries('.').each do |entry|
    puts entry
end
end
Dir.chdir(@copy_of_directory)
if !Dir.glob('*.mrc').empty?
    FileUtils.mv Dir.glob('**/*.mrc'),'mrc'
    Dir.chdir("mrc") 
    Dir.entries('.').each do |entry|
    puts entry
end
end
Dir.chdir(@copy_of_directory)
if !Dir.glob('*.Meta').empty?
    FileUtils.mv Dir.glob('**/*.Meta'),'xml'
    Dir.chdir("xml") 
    Dir.entries('.').each do |entry|    
    puts entry
    if m = entry.match('\d.*\.xml\.Meta')
    File.rename(entry, entry.gsub(".Meta", ""))
    puts "changed!"
    end
end
end
Dir.chdir(@copy_of_directory)
if !Dir.glob('*.zip').empty?
    FileUtils.mv Dir.glob('**/*.zip'),'zip'
    Dir.chdir("zip") 
    Dir.entries('.').each do |entry|
    puts entry
end
Dir.chdir(@copy_of_directory)
end
self
end
end

