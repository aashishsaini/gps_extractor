$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'erb'
require 'gps_extractor/version'
require 'fileutils'

module Template
  OutPutDir = "output"
  Dir.mkdir(OutPutDir) unless File.exists?(OutPutDir)
  # handles creating and writing CSV output files
  class Csv
    attr_reader :file_name

    # dir: basename of root directory
    # attr_labels: array of attributes labels as strings
    def initialize(dir, attr_labels)
      @file_name = "#{Template::OutPutDir}/#{dir}_#{Time.now.to_i}.csv"
      @file = File.new(@file_name, 'w')
      @file.puts(attr_labels.join(','))
    end

    # Writes data row to file
    def insert(img_attrs)
      @file.puts(img_attrs.join(','))
    end

    def close
      @file.close
    end
  end


  # This Class handles creating and writing HTML output files
  class Html
    attr_reader :file_name

    # dir: basename of root directory
    # attr_labels: array of attributes labels as strings
    def initialize(dir, attr_labels)
      @file_name = "#{Template::OutPutDir}/#{dir}_#{Time.now.to_i}.html"
      @file = File.new(@file_name, 'w')
      @template_path = set_template_path
      append_header(dir, attr_labels)
    end

    # Writes data row to file
    def insert(img_attrs)
      @img_attrs = img_attrs
      row = File.read("#{@template_path}_row.html.erb")
      partial = ERB.new(row, nil, '-').result(binding)
      @file.write(partial)
    end

    # Writes footer to file and closes it
    def close
      footer = File.read("#{@template_path}_footer.html.erb")
      partial = ERB.new(footer).result(binding)
      @file.write(partial)
      @file.close
    end

    private

    # locate path to templates
    def set_template_path
      template_path = 'lib/templates/html/'
      gem_path = "#{Gem.dir}/gems/gps_extractor-#{GpsExtractor::VERSION}/"
      if File.exists?(gem_path)
        return File.join(gem_path, template_path)
      else
        template_path
      end
    end

    # Writes the header component of the HTML file
    def append_header(dir, attr_labels)
      @title = "Image GPS Scan for: #{dir}"
      @attr_labels = attr_labels
      header = File.read("#{@template_path}_header.html.erb")
      partial = ERB.new(header, nil, '-').result(binding)
      @file.write(partial)
    end
  end
end