prompt = "> "
puts "What is the directory we are working with?"
print prompt
directory=gets
chomped_directory=directory.chomp

File.rename chomped_directory, "../Subject"


Dir.chdir("//Applications/SaxonHE9-7-0-15J")

`java -cp saxon9he.jar net.sf.saxon.Transform -t -s:/Users/amay02/Desktop/Subject/xml/ingestThis.xml -xsl:/Users/amay02/Desktop/RepoToolkit/transforms/subject.xslt -o:/Users/amay02/Desktop/Subject/xml/subjects.txt`

File.rename "../Subject", chomped_directory

puts "Would you like to open the file?"
print prompt

while input=gets.chomp
case input
  
when "Y", "y","Yes"
    puts 
    puts "Launching oXygen"
    puts 

file_to_open = chomped_directory+"/xml/subjects.txt"
system %{open "#{file_to_open}"}

break
when "N","No","n","Exit"
  puts ""
  puts "Gododbye" 
  puts "" 
  file_to_open = chomped_directory
  break
else 
  puts "Please select Yes or No."   
  print prompt 
end
end





