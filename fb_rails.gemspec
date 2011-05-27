# -*- encoding: utf-8 -*-
 
Gem::Specification.new do |s|
  s.name = 'fb_rails'
  s.version = '1.1.0'
  s.summary = 'Facebook on Rails'
  s.description = 'A Rails 3 gem for the latest facebook API'

  s.required_ruby_version     = '>= 1.8.7'
  s.required_rubygems_version = '>= 1.3.5'

  s.author            = 'Matthew Higgins'
  s.email             = 'developer@matthewhiggins.com'
  s.homepage          = 'http://github.com/matthuhiggins/fb_rails'

  s.extra_rdoc_files = ['README.rdoc']
  s.files = %w(MIT-LICENSE Rakefile README.rdoc) + Dir['{lib,test}/**/*.rb']
  s.require_path = 'lib'
  s.add_development_dependency('rails', '>= 3.0.0')
end
