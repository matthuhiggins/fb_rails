# -*- encoding: utf-8 -*-
 
Gem::Specification.new do |s|
  s.name = 'fb_rails'
  s.version = '0.1.0'
  s.summary = 'Facebook Connect'
  s.description = 'Facebook Connect'

  s.required_ruby_version     = '>= 1.8.6'
  s.required_rubygems_version = '>= 1.3.5'

  s.author            = 'Matthew Higgins'
  s.email             = 'developer@matthewhiggins.com'
  s.homepage          = 'http://gotime.com'
  s.rubyforge_project = 'fb_rails'

  s.extra_rdoc_files = ['README']
  s.files = %w(MIT-LICENSE Rakefile README) + Dir['lib/**/*.rb'] + Dir['test/**/*.rb']
  s.require_paths = %w(lib)  
end
