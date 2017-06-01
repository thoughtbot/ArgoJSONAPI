Pod::Spec.new do |s|
  s.name = "ArgoJSONAPI"
  s.version = %x(git describe --tags --abbrev=0).chomp
  s.summary = "An extension to Argo for parsing JSON API: http://jsonapi.org/"
  s.homepage = "https://github.com/thoughtbot/ArgoJSONAPI"
  s.license = { type: "MIT", file: "LICENSE" }
  s.author = {
    "Adam Sharp" => "",
  }
  s.social_media_url = "https://twitter.com/thoughtbot"
  s.platform = :ios, "8.0"
  s.source = { git: "https://github.com/thoughtbot/#{s.name}.git", tag: "#{s.version}" }
  s.source_files = "Sources/#{s.name}/**/*.{swift,h}"
  s.module_map = "Sources/#{s.name}/module.modulemap"
  s.public_header_files = "Sources/#{s.name}/#{s.name}.h"
end
