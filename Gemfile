source 'https://rubygems.org'

gem 'rails',                   '5.1.4'

# comment out, bundle install, gem install bcrypt --platform=ruby, uncomment out, bundle install
gem 'bcrypt',                  '3.1.11', platforms: [:ruby, :x64_mingw, :mingw] #to avoid bcrypt.rb:16:in `require': cannot load such file -- bcrypt_ext (LoadError).
gem 'faker',                   '1.7.3'
gem 'carrierwave',             '1.2.2'
gem 'mini_magick',             '4.7.0'
gem 'will_paginate',           '3.1.6'
gem 'bootstrap-will_paginate', '1.0.0'
gem  'ffi',                    '1.9.18' #ffi 1.9.21 can't be compiled on my Windows
gem 'bootstrap-sass',          '3.3.7'
gem 'puma',                    '3.9.1'
gem 'sass-rails',              '5.0.6'
gem 'uglifier',                '3.2.0'
gem 'coffee-rails',            '4.2.2'
gem 'jquery-rails',            '4.3.1'
gem 'turbolinks',              '5.0.1'
gem 'jbuilder',                '2.7.0'

group :development, :test do
  gem 'sqlite3', '1.3.13'
  gem 'byebug',  '9.0.6', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console',           '3.5.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'annotate'
end

group :test do
  gem 'rails-controller-testing', '1.0.2'
  gem 'minitest-reporters',       '1.1.14'
  gem 'guard',                    '2.14.1'
  gem 'guard-minitest',           '2.4.6'
end

group :production do
  gem 'pg',  '0.20.0'
  gem 'fog', '1.42'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'wdm', '>= 0.1.0' if Gem.win_platform?