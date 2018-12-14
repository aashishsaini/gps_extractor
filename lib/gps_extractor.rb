$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')
require "gps_extractor/version"
require 'optparse'
require 'extractor'

options = {}
parser = OptionParser.new do |opts|
  opts.on('-html', 'Output HTML file') do
    options[:html] = true
  end

  opts.on('-v', '--verbose', 'Run verbosely') do |v|
    options[:verbose] = v
  end
end

begin
  parser.parse!
rescue OptionParser::InvalidOption => e
  STDERR.puts e.message
  STDERR.puts parser
  exit
end

Extractor.new.perform(options, ARGV)