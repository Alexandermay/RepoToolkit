# Gets users directory and makes a copy in TempRepo
module SetDirectories
  def initialize
    require 'fileutils'
    @toolkit_path = File.expand_path('..', File.dirname(__FILE__))
    @copy_of_directory = @toolkit_path + '/TempRepo'
    FileUtils.mkdir_p @copy_of_directory
    puts 'What is the directory you are working with?'
    print $prompt
    @user_directory = gets.chomp.strip
    FileUtils.copy_entry @user_directory, @copy_of_directory
    Dir.chdir(@copy_of_directory)
    self
  end

  def close_directories
    Dir.chdir(@copy_of_directory + '/..')
    FileUtils.remove_entry @user_directory
    FileUtils.copy_entry @copy_of_directory, @user_directory
    FileUtils.remove_dir @copy_of_directory
    self
  end
end
