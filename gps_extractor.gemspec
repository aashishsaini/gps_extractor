$:.push File.expand_path("../lib", __FILE__)

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "gps_extractor/version"

Gem::Specification.new do |spec|
  spec.name          = "gps_extractor"
  spec.version       = GpsExtractor::VERSION
  spec.authors       = ["Aashish Saini"]
  spec.email         = ["aashusaini2684@gmail.com"]

  spec.summary       = %q{CL app to find JPEGs and extract their GPS coordinates}
  spec.description   = %q{
    A command line application that recursively reads all of the images from the supplied directory of images,
    extracts their EXIF GPS data (longitude and latitude), and then writes the name of that image and any
    GPS co-ordinates it finds to a CSV file.

    Results are written to a file in the pwd as the scan runs. CSV files will be
    produced by default, use -html for HTML files instead. If the app is not
    installed as a gem, HTML output requires configuration.
  }
  spec.homepage      = "https://github.com/aashishsaini/"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/aashishsaini/gps_extractor"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.files = %w(
    lib/gps_extractor.rb
    lib/file_scanner.rb
    lib/extractor.rb
    lib/gps_extractor/version.rb
    lib/template.rb
    lib/templates/html/_header.html.erb
    lib/templates/html/_row.html.erb
    lib/templates/html/_footer.html.erb
  )

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency('exifr', '~> 1.3', '>= 1.3.4')
end
