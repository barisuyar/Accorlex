Pod::Spec.new do |s|

  s.name                = "Accorlex"
  s.version             = "1.0.0"
  s.summary             = "This is a accordion menu implemented in Swift."
  s.homepage            = "https://github.com/barisuyar/Accorlex.git"
  s.license             = "MIT"
  s.author              = { "Barış UYAR" => "baris.uyar@hotmail.com" }
  s.social_media_url    = "http://twitter.com/prospectcha"
  s.platform            = :ios, "9.2"
  s.source              = { :git => "https://github.com/barisuyar/Accorlex.git", :tag => "#{s.version}" }
  s.source_files        = "Accorlex/Accorlex/**/*"
  s.exclude_files = "Accorlex/Accorlex/*.plist"

end
