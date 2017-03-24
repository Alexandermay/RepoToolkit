#Superclass
class Tufts_Scholarship
  require './set_directories.rb'
  include SetDirectories
  require './set_subdirectories.rb'
  include CreateSubdirectories
  require './create_collection_xml.rb'
  include Collection_XML
  require './transform_xml.rb'  
  include Transforms
  require './package_binaries.rb'  
  include PackageBinaries
  require './pre_post_process_xml.rb'  
  include CleanUpXML
  require './qa_final_product.rb'  
  include QA
end
#Children of the superclass
class Excel_Based_Ingest < Tufts_Scholarship
  require './excel_to_roo.rb'
  include ToRoo
  def extract_it
    excel_subfolders.roo_to_xml.transform_excel.create_collection
  end  
  def finish_it
    postprocess_excel_xml.close_directories.qa_it
  end
end
class Springer_Ingest < Tufts_Scholarship
  require './unzip_directories.rb'
  include UnzipIt
  def extract_it
    springer_subfolders.unzip
  end
  def transform_it
    preprocess_springer_xml.create_collection.transform_it_springer
  end
  def finish_it
    postprocess_springer_xml.close_directories.qa_it
  end 
end
class Proquest_Ingest < Tufts_Scholarship
  require './unzip_directories.rb'
  include UnzipIt
  def extract_it
    proquest_subfolders.unzip
  end
  def transform_it
    create_collection.transform_it_proquest
  end
  def finish_it
    postprocess_proquest_xml.close_directories.qa_it
  end
end
class Subject_Analysis < Tufts_Scholarship
  require './subject_analysis.rb'
  include AnalyzeIt  
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
puts "6. Proquest Electronic Disertations and Theses."
puts "7. In-House (placeholder only)"
puts "8. Subject Analysis."
puts "9. Exit"
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
    a_new_faculty_ingest.extract_it.transform_it_faculty.package_it_up.finish_it
    break

when "2","2.","Student"
    puts
    puts "Launching the Student Scholarship script."
    a_new_student_ingest = Excel_Based_Ingest.new
    a_new_student_ingest.extract_it.transform_it_student.package_it_up.finish_it
    break

when "3","3.","Nutrition"
    puts
    puts "Launching the Nutrtion Scholarship script."
    a_new_nutrition_ingest = Excel_Based_Ingest.new
    a_new_nutrition_ingest.extract_it.transform_it_nutrition.package_it_up.finish_it
    break

when "4","4.","Trove"
    puts
    puts "Launching the Trove script."
    a_new_trove_ingest = Excel_Based_Ingest.new
    a_new_trove_ingest.extract_it.transform_it_trove.package_it_up.finish_it
    break
    
when "5","5.","Springer"
    puts
    puts "Launching the Springer script."
    a_new_springer_ingest = Springer_Ingest.new
    a_new_springer_ingest.extract_it.transform_it.package_it_up.finish_it
break

when "6","6.","Proquest"
    puts
    puts "Launching the Proquest script."
    a_new_proquest_ingest = Proquest_Ingest.new
    a_new_proquest_ingest.extract_it.transform_it.package_it_up.finish_it
break

when "7","7.","inHouse"
    puts
    puts "I'm not ready yet."
break

when "8","8.","Subject"
    puts
    puts "Launching the Subject Analysis script"
    a_new_analysis = Subject_Analysis.new
    a_new_analysis.subject_only.finish.re_qa_subject
break

when "9", "9.", "9. Exit", "Exit"
  puts ""
  puts "Goodbye." 
  break
else 
  puts "Please select from the above options."   
  print prompt       
  end
end



