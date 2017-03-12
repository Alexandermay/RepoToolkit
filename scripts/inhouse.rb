#Gets user input
prompt = "> "
puts "What is the directory you are working with?"
print prompt
user_directory=gets.chomp
#Takes user Directory and makes a copy in TempRepo
require 'fileutils'
copy_of_directory = File.expand_path("~/Library/TempRepo/Directory")
launcher = File.expand_path("~/Desktop/RepoToolkit/scripts")
FileUtils.copy_entry user_directory, copy_of_directory
#Change directory to the copy and create subfolders for processesing
Dir.chdir(copy_of_directory)
filex=Dir.glob('*.xml').to_s.gsub(/\[\"|\"\]/,'')
File.rename filex,'inHouse.xml'
Dir.mkdir("xml")
Dir.mkdir("pdf")
Dir.mkdir("mrc")
#Puts xml in an xml folder  
  FileUtils.mv Dir.glob('**/*.xml'),'xml'
    Dir.chdir("xml") 
    Dir.entries('.').each do |entry|
      puts entry
    end
#Puts pdfs in a pdf folder  
  Dir.chdir("..")
  FileUtils.mv Dir.glob('**/*.pdf'),'pdf'
    Dir.chdir("pdf") 
      Dir.entries('.').each do |entry|
      puts entry
    end
#Puts mrc in a mrc folder
  Dir.chdir("..")
  FileUtils.mv Dir.glob('**/*.mrc'),'mrc'
    Dir.chdir("mrc") 
      Dir.entries('.').each do |entry|
      puts entry
      end
#These xslts produce the ingest xml
Dir.chdir("../xml")
`java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:./inHouse.xml -xsl:../../../../Desktop/RepoToolkit/transforms/inhouse.xslt -o:./ingestThis.xml`
#Now we clean everything up and copy the temp files back into the original source folder
File.rename 'inHouse.xml',filex
Dir.chdir(copy_of_directory)
require 'fileutils'
FileUtils.remove_entry user_directory
FileUtils.copy_entry copy_of_directory, user_directory
FileUtils.remove_dir copy_of_directory
puts "Cleaning-up."
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
