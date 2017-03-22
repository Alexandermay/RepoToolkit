#Superclass
class Tufts_Scholarship
  require './set_directories.rb'
  include SetInitialDirectories
  require './set_subdirectories.rb'
  include CreateSubdirectories
  require './create_collection_xml.rb'
  include Collection_XML
  require './transform_xml.rb'  
  include Transforms
  require './package_binaries.rb'  
  include PackageBinaries
  require './clean_directories.rb'  
  include CleanUp
  require './qa_final_product.rb'  
  include QA
end
#Childern of the superclass
class Excel_Based_Ingest < Tufts_Scholarship
  require './excel_to_roo.rb'
  include ToRoo
  def extract_it
    scholarship_folders.roo_to_xml.extract_scholarship.create_collection
  end
  def package_it
    gobble_xml.gobble_subjects.gobble_excel
  end
  def finish_it
    clean_excel.finish.qa_it
  end
end
class Zip_Based_Ingest < Tufts_Scholarship
  require './unzip_directories.rb'
  include UnzipIt
end

puts `clear`
puts"***************************************************"
puts
puts "Welcome to the Repository Toolkit!"
puts 
puts "What would you like to process?"
puts
puts "1. Faculty Scholarship."
puts "2. Student Scholarship."
puts "3. Nutrition School."
puts "4. Art and Art History (Trove)."
puts "5. Springer Open Access Articles."
puts "6. Proquest Electronic Disertations and Theses"
puts "7. "
puts "8. Exit"
puts
prompt = "> "
print prompt
#Loop
while input=gets.chomp
case input
when "1","1.","Faculty"
    puts
    puts "Launching the Faculty Scholarship script."
    a_new_faculty_ingest = Excel_Based_Ingest.new
    a_new_faculty_ingest.extract_it.to_faculty.package_it.gobble_pdf.finish_it
    break

when "2","2.","Student"
    puts
    puts "Launching the Student Scholarship script."
    a_new_student_ingest = Excel_Based_Ingest.new
    a_new_student_ingest.extract_it.to_student.package_it.gobble_pdf.finish_it
    break

when "3","3.","Nutrition"
    puts
    puts "Launching the Nutrtion Scholarship script."
    a_new_nutrition_ingest = Excel_Based_Ingest.new
    a_new_nutrition_ingest.extract_it.to_nutrition.package_it.gobble_pdf.finish_it
    break

when "4","4.","Trove"
    puts
    puts "Launching the Trove script."
    a_new_trove_ingest = Excel_Based_Ingest.new
    a_new_trove_ingest.trove_folders.roo_to_xml.extract_trove.create_collection.to_trove.package_it.gobble_tif.finish_it
    break
    
when "5","5.","Springer"
    puts
    puts "Launching the Springer script."
    a_new_springer_ingest = Zip_Based_Ingest.new
    a_new_springer_ingest.springer_folders.unzip.gobble_springer_xml.create_collection.to_springer.gobble_pdf.gobble_zip.gobble_springer.clean_springer.finish.qa_it
break

when "6","6.","Proquest"
    puts
    puts "Launching the Proquest script."
    a_new_proquest_ingest = Zip_Based_Ingest.new
    a_new_proquest_ingest.proquest_folders.unzip.create_collection.to_proquest.gobble_xml.gobble_subjects.gobble_pdf.gobble_zip.clean_proquest.finish.qa_it
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



