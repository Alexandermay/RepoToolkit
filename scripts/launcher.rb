#First we need to set the path to the copy of user's directory where the changes will occur
require 'fileutils'
path_to_copy = File.expand_path("~/Library")
FileUtils.mkdir_p path_to_copy+'/TempRepo'
#Get user input
puts `clear`
puts"***************************************************"
puts
puts "Welcome to the Repository Toolkit!"
puts 
puts "What would you like to process?"
puts
puts "1. Proquest Electronic Disertations and Theses."
puts "2. Springer Open Access Articles."
puts "3. Art and Art History (Trove)."
puts "4. Faculty Scholarship."
puts "5. Student Scholarship"
puts "6. InHouse Digitization files."
puts "7. Cataloger Subject Analysis."
puts "8. Exit"
puts
prompt = "> "
print prompt
#Loop
while input=gets.chomp
case input
when "1"
    puts
    puts "Launching the Proquest processing script"
    system("ruby proquest.rb")
    puts
    break
when "2", "2.", "2. Springer Open Access Articles.","Springer"
    puts 
    puts "Launching the Springer processing script."
    system("ruby springer.rb")
    puts
    break   
when "3", "3.", "3. Art and Art History.","Trove"
    puts 
    puts "Launching the Trove processing script."
    system("ruby trove.rb")
    puts
    break     
when "4", "4.", "4. Faculty Scolarship", "Faculty"
    puts 
    puts "Launching the Faculty Scholarship script."
    system("ruby faculty.rb")
    puts
    break    
when "5", "5.", "5. Student Scolarship", "Student"
    puts 
    puts "Launching the Student Scholarship script."
    system("ruby student.rb")
    puts
    break   
when "6", "6.", "6. InHouse Digitization","inHouse","Digitization"
    puts 
    puts "Launching the inHouse Digitization script."
    system("ruby inhouse.rb")
    puts
    break    
when "7", "7.", "7. Subjects.","Subject"
    puts 
    puts "Launching the Subject Analysis script."
    system("ruby subject.rb")
    puts
    break
when "8", "8.", "8. Exit", "Exit"
    puts ""
    puts "Goodbye." 
    break
else 
  puts "Please select from the above options."   
  print prompt   
end    
end

    