$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'pathname'
require 'template'
require 'file_scanner'

class Extractor
  def perform(options, args)
    show_throughput('Setting directory', options[:verbose])
    dir = get_directory(args)

    show_throughput('Create output file', options[:verbose])
    output_file = op_file(dir, options)

    begin
      show_throughput('Scan Started', options[:verbose])
      FileScanner.new(dir, output_file, options[:verbose]).begin_scan
    rescue SystemCallError => e
      show_error('Unable to scan this directory', e)
    rescue StandardError => e
      show_error('', e)
    end
    show_throughput('Scan Completed', options[:verbose])

    show_throughput('Finalising O/P File', options[:verbose])
    output_file.close

    show_throughput('Exit', options[:verbose])
    show_throughput("OutPut Recorded in file: #{output_file.file_name}", true)
    exit
  end

  def get_directory(args)
    begin
      case args.count
        when 0
          Dir.pwd
        when 1
          File.absolute_path(args.first)
        else
          raise ArgumentError, 'Arguments limit breached'
      end
    rescue ArgumentError => e
      show_error('Unable to set directory', e)
    end
  end

  def op_file(dir,options)
    begin
      attr_labels = %w[directory file_name latitude longitude]
      dir_name = File.basename(dir)
      if options[:html]
        Template::Html.new(dir_name, attr_labels)
      else
        Template::Csv.new(dir_name, attr_labels)
      end

    rescue SystemCallError => e
      STDERR.puts 'Unable to initialize the output file'
      STDERR.puts 'Make sure you have write permission to your pwd'
      if options[:html]
        STDERR.puts 'If you have not installed the gem, check your config file'
      end
      STDERR.puts e.message
      exit
    end
  end

  def show_throughput(msg, verbose)
    puts msg if verbose
  end

  def show_error(msg, e)
    STDERR.puts msg
    STDERR.puts e.message
    exit
  end
end