module SetInitialDirectories
  def initialize
    require 'fileutils'
    @path_to_copy = File.expand_path("~/Library")
    FileUtils.mkdir_p @path_to_copy+'/TempRepo'
    @prompt = "> "
    puts "What is the directory you are working with?"
    print @prompt
    @user_directory=gets.chomp
    @copy_of_directory = File.expand_path("~/Library/TempRepo/Directory") 
    FileUtils.copy_entry @user_directory, @copy_of_directory 
    Dir.chdir(@copy_of_directory)
    self
  end
  def finish
    FileUtils.remove_entry @user_directory
    FileUtils.copy_entry @copy_of_directory, @user_directory
    FileUtils.remove_dir @copy_of_directory
    self
  end
end
