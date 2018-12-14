require 'exifr/jpeg'

class ImageReader
  def initialize(image_path)
    @directory, @file_name = File.split(image_path)
    begin
      image_exif = EXIFR::JPEG.new(image_path)
      @latitude = image_exif.gps.latitude
      @longitude = image_exif.gps.longitude
    rescue NoMethodError
      # Sets gps coordinates to nil if EXIF data is missing
      @latitude = nil
      @longitude = nil
    end
  end

  # Returns instance variables as an array
  def restructure
    [@directory, @file_name, @longitude, @latitude]
  end
end