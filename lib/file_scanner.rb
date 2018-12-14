$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'pathname'
require 'image_reader'
require 'extractor'

class FileScanner
  def initialize(directory, output_file, verbose)
    @directory = Pathname.new(directory)
    @output_file = output_file
    @verbose = verbose
    @allowed_formats = %w{.jpg .jpeg}
  end

  def begin_scan
    directory_scanning(@directory)
  end

  private

  # Recursively scans directory searching for image files
  def directory_scanning(dir)
    Extractor.new.show_throughput("scanning path: #{dir}", @verbose)

    dir.children.each do |child|
      if child.file? && @allowed_formats.include?(File.extname(child).downcase)
        begin
          @output_file.insert(ImageReader.new(child.to_path).restructure)
        rescue EXIFR::MalformedJPEG => e
          Extractor.new.show_throughput("Unprocessable image: #{child.to_path}", @verbose)
          Extractor.new.show_throughput(e.message, @verbose)
        rescue SystemCallError => e
          Extractor.new.show_throughput("An error occurred while processing image: #{child.to_path}", @verbose)
          raise SystemCallError, "The error received was: #{e}"
        end
      elsif child.directory?
        begin
          directory_scanning(child)
        rescue SystemCallError => e
          Extractor.new.show_throughput("Unable to scan sub directory: #{child.to_path}", @verbose)
          Extractor.new.show_throughput(e.message, @verbose)
        end
      end
    end
  end
end