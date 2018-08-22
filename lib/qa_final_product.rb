# Open proceesed xml and run subject analysis
module QA
  require_relative './set_directories.rb'
  include SetDirectories

  def qa_it
    puts 'Would you like to open the tranformed xml?'
    print $prompt
    while input = gets.chomp
      case input
      when 'Y', 'y', 'Yes'
        puts
        puts 'Launching applications.'
        puts
        Dir.chdir(@user_directory + '/xml')
        file_to_open = @f+'_Ingest.xml'
        if $is_windows then
          system %(start #{file_to_open})
        else
          system %(open '#{file_to_open}')
        end
        file_to_open = 'subjects.txt'
        if $is_windows then
          system %(start #{file_to_open})
        else
          system %(open '#{file_to_open}')
        end
        break
      when 'N', 'No', 'n', 'Exit'
        puts 'Goodbye.'
        break
      else
        puts 'Please select Yes or No.'
        print $prompt
      end
    end
  end
end
