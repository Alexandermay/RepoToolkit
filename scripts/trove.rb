#Gets user input
prompt = "> "
puts "What is the directory you are working with?"
print prompt
user_directory=gets.chomp
#Set up some paths, and make a copy of the user's directory in TempRepo
require 'fileutils'
copy_of_directory = File.expand_path("~/Library/TempRepo/Directory")
launcher = File.expand_path("~/Desktop/RepoToolkit/scripts")
FileUtils.copy_entry user_directory, copy_of_directory
#Change directory to the copy and create subfolders for processesing
Dir.chdir(copy_of_directory)
Dir.mkdir("xml")
Dir.mkdir("excel")
Dir.mkdir("tif")
#Captures the name of the original Excel
filex=Dir.glob('*.xlsx').to_s.gsub(/\[\"|\"\]/,'')
#Outputs Excel as xml
require 'roo'
work = Roo::Spreadsheet.open(filex)
test = File.open("firstTransform.xml", "w+")
test.puts work.to_xml
test.close
#Transforms roo xml into usable xml
`java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:./firstTransform.xml -xsl:../../../Desktop/RepoToolkit/transforms/extractExcel_trove.xslt -o:./workWithThis.xml`
#Creates a collection.xml document(for collection function in xslt2.0) in puts it into a folder named xml with all other xml
Dir.chdir(copy_of_directory)
require 'fileutils'
FileUtils.mv Dir.glob('**/*.xml'),'xml'
Dir.chdir("xml")
Dir.entries('.').each do |entry|
  puts entry
  end
  collection = File.open("collection.xml", "w+") 
  collection.puts("<?xml version=\"1.0\" encoding = \"UTF-8\"?>")
  collection.puts("<collection>")
  Dir.glob('*.xml').reject{|f| f['collection.xml']}.each do |entry2|    
  collection.puts (entry2.gsub(/(\w.+\.xml)/,"<doc href=\"\\0\"/>")) 
  end  
  collection.puts("</collection>")
#Puts excel in an excel folder  
  Dir.chdir("..")
      FileUtils.mv Dir.glob('**/*.xlsx'),'excel'
      Dir.chdir("excel") 
      Dir.entries('.').each do |entry|
       puts entry
     end
#Puts tifs in a tif folder
  Dir.chdir("..")
      FileUtils.mv Dir.glob('**/*.tif'),'tif'
      Dir.chdir("tif") 
      Dir.entries('.').each do |entry|
       puts entry
     end
collection.close
#These xslts produce the ingest xml and subject txt
Dir.chdir("../xml")
`java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:./collection.xml -xsl:../../../../Desktop/RepoToolkit/transforms/Trove.xslt -o:./ingestThis.xml`
`java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:./ingestThis.xml -xsl:../../../../Desktop/RepoToolkit/transforms/subject.xslt -o:./subjects.txt`
#Now we clean everything up and copy the temp files back into the original source folder
Dir.chdir(copy_of_directory+'/xml')
require 'fileutils'
FileUtils.rm('firstTransform.xml')
FileUtils.rm('workWithThis.xml')
FileUtils.rm('collection.xml')
FileUtils.remove_entry user_directory
FileUtils.copy_entry copy_of_directory, user_directory
FileUtils.remove_dir copy_of_directory
#Change our directory so we can process the xml
Dir.chdir(user_directory)
puts "Would you like to open the tranformed xml?"
print prompt
#If yes, open system applications for xml and text, relaunch the launcher
while input=gets.chomp
case input
when "Y", "y","Yes"
    puts 
    puts "Launching oXygen"
    puts 
file_to_open = user_directory+"/xml/ingestThis.xml"
system %{open "#{file_to_open}"}
file_to_open = user_directory+"/xml/subjects.txt"
system %{open "#{file_to_open}"}
Dir.chdir(launcher)
system("ruby launcher.rb")
break
#If no relaunch the launcher
when "N","No","n","Exit"
  Dir.chdir(launcher)
  system("ruby launcher.rb")
  break
else 
  puts "Please select Yes or No."   
  print prompt 
end
end





