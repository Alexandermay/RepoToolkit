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
Dir.chdir(copy_of_directory+'/xml')
filex=Dir.glob('*.xml').to_s.gsub(/\[\"|\"\]/,'')
File.rename filex,'ingestThis.xml'
`java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:ingestThis.xml -xsl:../../../../Desktop/RepoToolkit/transforms/subject.xslt -o:subjects.txt`
File.rename 'ingestThis.xml',filex
Dir.chdir(copy_of_directory+'/xml')
require 'fileutils'
FileUtils.remove_entry user_directory
FileUtils.copy_entry copy_of_directory, user_directory
FileUtils.remove_dir copy_of_directory
#Change our directory so we can process the xml
Dir.chdir(user_directory)
puts "Would you like to open the file?"
print prompt
while input=gets.chomp
case input 
when "Y", "y","Yes"
    puts 
    puts "Launching oXygen"
    puts 
file_to_open = user_directory+"/xml/subjects.txt"
system %{open "#{file_to_open}"}
Dir.chdir(launcher)
system("ruby launcher.rb")
break
when "N","No","n","Exit"
  Dir.chdir(launcher)
  system("ruby launcher.rb")
  break
else 
  puts "Please select Yes or No."   
  print prompt 
end
end





