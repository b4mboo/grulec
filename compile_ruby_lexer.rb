#!/usr/bin/env ruby
# This script will automatically compile Gherkin's ruby lexer.

# If this script is called with an optional --app parameter switch directories.
Dir.chdir ARGV[1] if ARGV[0] == '--app'

# Get the correct path to the currently used gherkin gem.
gem_info = `bundle exec gem environment`.lines
gem_path = gem_info.find{ |line| line.include? 'INSTALLATION' }.split.last
gherkin_version = `bundle exec gem list | grep gherkin`.chomp[/\((.*?)\)/m, 1]
gherkin_path = gem_path + '/gems/gherkin-' + gherkin_version

# Check existence of all required tools.
raise 'Gherkin gem not found.' unless Dir.exist? gherkin_path
raise 'Ragel not found.' unless `ragel -v`.include? 'Ragel State Machine'

# Adjust possibly existing .ruby-version file to work well with rbenv.
ruby_version = `ruby -v`.split[1]
ruby_version_lock = gherkin_path + '/.ruby-version'
if File.exist? ruby_version_lock
  File.open(ruby_version_lock, 'w') do |out|
    out << ruby_version
  end
end

# Bundle Gherkin's required gems for development.
Dir.chdir gherkin_path
`bundle`

# In case we're using rbenv, we might have to rehash.
`rbenv rehash` if system 'which rbenv > /dev/null 2>&1'

# Finally, compile the lexer.
`bundle exec rake compile:gherkin_lexer_en`
raise 'Compiling the ruby lexer failed.' unless $?.exitstatus == 0
puts 'Ruby lexer successfully compiled.'
