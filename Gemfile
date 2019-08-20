source 'https://gems.ruby-china.com'

## rails
## {{
gem 'rails', '4.2.0'
gem 'sass-rails', '~> 5.0'                  # css
gem 'uglifier', '>= 1.3.0'                  # javascript
gem 'coffee-rails', '~> 4.1.0'              # coffeescript
gem 'jquery-rails'                          # jquery
gem 'turbolinks'                            # generate links
gem 'jbuilder', '~> 2.0'                    # json
gem 'sdoc', '~> 0.4.0', group: :doc         # `rake doc:rails` -- generate API under doc/api
# gem 'rufus-scheduler'                       # scheduler
## }}

## database
## {{
gem 'mysql2', '~> 0.3.18'                   # mysql adapter
gem 'enumerize', '~> 0.10.1'                # enum type
gem 'flag_shih_tzu', '~> 0.3.13'            # bit field
# gem 'paperclip', '~> 4.2.1'                 # file attach
gem 'ransack', '~> 1.6.6'                   # search
gem 'faker', '~> 1.4.3'                     # fake data
gem 'sequel','~> 5.7.1'
## }}

## auth
## {{
gem 'devise', '~> 3.4.1'                    # auth
gem 'cancancan', '~> 1.10.1'                # access
## }}

## view
## {{
gem 'haml-rails', '~> 0.9.0'                # haml tempalte
gem 'erb2haml', '~> 0.1.5', group: :development
gem 'kaminari', '~> 0.16.3'                 # pagination
gem 'simple_form', '~> 3.1.0'               # form
gem 'cocoon', '~> 1.2.0'                    # nested form
gem 'foundation-rails', '~> 5.5.2.1'        # zurb-foundation
gem 'autosize', '~> 1.1'                    # autosize for textarea
## }}

## messaging
gem 'stomp'                                 # Ruby STOMP Client

## auto-complete
gem 'jquery-ui-rails'
gem 'rails-jquery-autocomplete'

# debugging
gem 'web-console', '~> 2.0', group: :development

#IMGKig
gem 'imgkit', '~> 1.6.1'
gem 'wkhtmltoimage-binary'

## group
group :development, :test do
  gem 'minitest-reporters'
  gem 'byebug'
  gem 'spring'                              # dev server
  gem 'pry-rails', '~> 0.3.4'               # pry debug
  gem 'timecop', '~> 0.7.3'                 # time travel control
end

group :test do
  gem 'factory_girl_rails', '~> 4.5.0'      # generate spec model
  gem 'database_cleaner', '~> 1.4.1'        # reset on test
  gem 'rspec-rails', '~> 3.2.1'             # replace test
end

group :production do
  gem 'unicorn-rails', '~> 2.2.0'
end

gem 'whenever', '0.9.7', :require => false # whenever --update-crontab (scheduler)
