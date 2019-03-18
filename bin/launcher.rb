# RepoToolKit last update 2018-10-13
Dir['../lib/*.rb'].each { |f| require_relative f }
# Superclass
class TuftsScholarship
  include SetDirectories
  include CleanFileNames
  include CreateSubdirectories
  include CollectionXML
  include Transforms
  include PackageBinaries
  include CleanUpXML
  include QA
end
# Excel ingest processes
class ExcelBasedIngest < TuftsScholarship
  include ToRoo
  def extract
    clean.excel_subfolders.roo_to_xml
  end

  def finish
    package.postprocess_excel_xml.close_directories.qa_it
  end
end
# Specific ingest issues for Springer
class SpringerIngest < TuftsScholarship
  include UnzipIt
  def extract
    springer_subfolders.unzip
  end

  def transform_it
    preprocess_springer_xml.collection.transform_it_springer
  end

  def finish
    package.postprocess_springer_xml.close_directories.qa_it
  end
end
# Specific ingest issues for Proquest
class ProquestIngest < TuftsScholarship
  include UnzipIt

  def extract
    proquest_subfolders.unzip
  end

  def transform_it
    collection.transform_it_proquest
  end

  def finish
    package.postprocess_proquest_xml.close_directories.qa_it
  end
end
# Specific ingest issues for MARC xml
class InHouseIngest < TuftsScholarship
  include Rename

  def extract
    inhouse_subfolders
  end

  def transform
    rename_mrc_xml.transform_it_inhouse.rename_xml_to_original
  end

  def finish
    package.postprocess_alma_xml.close_directories.qa_it
  end
end
# Create a list of subjects used by catalogers
class SubjectAnalysis < TuftsScholarship
  include AnalyzeIt
end

$is_windows = (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/)
$prompt = '> '
$saxon_path = ENV['SAXON_PATH']
$xslt_path = File.expand_path('../xslt', File.dirname(__FILE__))

if !$saxon_path then
  puts
  puts 'The environment variable SAXON_PATH is missing or blank.'
  puts 'SAXON_PATH must contain the full pathname to the saxon jar file.'
  puts 'Goodbye.'
  exit
end

if $is_windows then
  system ("cls")
else
  system ("clear")
end

require 'colorized_string'

puts '***************************************************'
puts
puts ColorizedString['Welcome to the Repository Toolkit for MIRA 1.0 for use for Trove Only!'].colorize(:yellow).underline
puts
puts 'What would you like to process?'
puts
puts '1. Art and Art History (Trove).'
puts '2. Subject Analysis.'
puts '3. Exit.'
puts

print $prompt
# Loop
while input = gets.chomp.strip
  case input
    
  when '1', '1.', 'Trove'
    puts
    puts 'Launching the Trove script.'
    a_new_trove_ingest = ExcelBasedIngest.new
    a_new_trove_ingest.extract.trove.excel.collection.transform.finish
    break


  when '2', '2.', 'Subject'
    puts
    puts 'Launching the Subject Analysis script'
    a_new_analysis = SubjectAnalysis.new
    a_new_analysis.subject_only.close_directories.re_qa_subject
    break

  when '3', '3.', '3. Exit', 'Exit'
    puts
    puts 'Goodbye.'
    break

  else
    puts 'Please select from the above options.'
    print $prompt
  end
end
