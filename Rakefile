# written by travis jeffery <travisjeffery@gmail.com>
# contributions by scrooloose <github:scrooloose>

require 'rake'
require 'find'
require 'pathname'

PLUGIN = [
<<<<<<< HEAD
  "ftplugin/javascript/jslint.vim",
  "ftplugin/javascript/jslint/fulljslint.js",
  "ftplugin/javascript/jslint/runjslint.js",
  "ftplugin/javascript/jslint/runjslint.wsf",
  "README.markdown",
  "LICENSE"
]

files = PLUGIN

desc 'Zip up the project files'
task :zip do
  zip_name = File.basename(File.dirname(__FILE__))
  zip_name.gsub!(/ /, '_')
  zip_name = "#{zip_name}.zip"

  if File.exist?(zip_name)
    abort("Zip file #{zip_name} already exists. Remove it first.")
  end

  puts "Creating zip file: #{zip_name}"
  system("zip #{zip_name} #{files.join(" ")}")
end

desc 'Install plugin and documentation'
task :install do
  vimfiles = if ENV['VIMFILES']
               ENV['VIMFILES']
             elsif RUBY_PLATFORM =~ /(win|w)32$/
               File.expand_path("~/vimfiles")
             else
               File.expand_path("~/.vim")
             end
  target_dir = File.join(vimfiles, 'ftplugin', 'javascript', 'jslint')
  FileUtils.mkdir_p target_dir
  files.each do |file|
    FileUtils.cp file, target_dir
    puts "Installed #{file} to #{target_dir}/"
  end

end

desc 'Pulls from origin'
task :pull do
  puts "Updating local repo..."
  system("cd " << Dir.new(File.dirname(__FILE__)).path << " && git pull")
end

desc 'Calls pull task and then install task'
task :update => ['pull', 'install'] do
  puts "Update of vim script complete."
end

task :default => ['update']
