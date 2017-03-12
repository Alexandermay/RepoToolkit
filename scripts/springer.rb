#Gets user input
prompt = "> "
puts "What is the directory you are working with?"
print prompt
user_directory=gets.chomp
puts 
puts 
print "...Analyzing directory... "
#Takes user Directory and makes a copy in TempRepo
require 'fileutils'
copy_of_directory = File.expand_path("~/Library/TempRepo/Directory")
launcher = File.expand_path("~/Desktop/RepoToolkit/scripts")
FileUtils.copy_entry user_directory, copy_of_directory
#Change directory to the copy and create subfolders for processesing
Dir.chdir(copy_of_directory)
Dir.mkdir("xml")
Dir.mkdir("pdf")
Dir.mkdir("zip")
Dir.mkdir("springer")
#Unzip Springer
print "Unziping...please be patient as this may take a while."
`unzip '*.zip'`
#Cleans-up Springer naming convention, moves xml into a folder named xml
require 'fileutils'
FileUtils.mv Dir.glob('**/*.Meta'),'xml'
Dir.chdir("xml")
Dir.entries('.').each do |entry|
  puts entry
   if m = entry.match('\d.*\.xml\.Meta')
     File.rename(entry, entry.gsub(".Meta", ""))
      puts "changed!"     
  end
  end
#Creates a collection.xml document(for collection function in xslt2.0) in puts it into a folder named xml with all other xml
  collection = File.open("collection.xml", "w+") 
  collection.puts("<?xml version=\"1.0\" encoding = \"UTF-8\"?>")
  collection.puts("<collection>")
  Dir.glob('*.xml').reject{|f| f['collection.xml']}.each do |entry2|  
  collection.puts (entry2.gsub(/(\d.+\.xml)/,"<doc href=\"\\0\"/>"))
  end  
  collection.puts("</collection>")
#Puts pdfs in a pdf folder  
    Dir.chdir("..")
        FileUtils.mv Dir.glob('**/*.pdf'),'pdf'
        Dir.chdir("pdf") 
        Dir.entries('.').each do |entry|
         puts entry
       end
#Puts zips in a zip folder
    Dir.chdir("..")
        FileUtils.mv Dir.glob('**/*.zip'),'zip'
        Dir.chdir("pdf") 
        Dir.entries('.').each do |entry|
         puts entry
       end
#Gather-up and Remove Springer Folders--this feels verbose, look into consolodating
Dir.chdir("..")
 FileUtils.mv Dir.glob('JOU*'),'springer'
 Dir.chdir("springer") 
 Dir.entries('.').each do |entry|
  puts entry
end
Dir.chdir("..")
FileUtils.remove_entry 'springer'
#Close out the collection so xslt can process
collection.close
#These xslts produce the ingest xml
Dir.chdir("xml")
`java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:./collection.xml -xsl:../../../../Desktop/RepoToolkit/transforms/Springer.xslt -o:../pdf/1_ingestThis.xml`
#Now we clean everything up and copy the temp files back into the original source folder
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
file_to_open = user_directory+"/pdf/1_ingestThis.xml"
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

