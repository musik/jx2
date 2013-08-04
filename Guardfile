# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'bundler' do
  watch('Gemfile')
  # Uncomment next line if Gemfile contain `gemspec' command
  # watch(/^.+\.gemspec/)
end

guard 'livereload' do
  watch(%r{app/views/.+\.(erb|haml|slim)})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)/assets/\w+/(.+\.(css|js|html)).*})  { |m| "/assets/#{m[2]}" }
end

guard 'rails',:server=>:thin,:port=>4005 do
  watch('Gemfile.lock')
  watch(%r{^(config/(environments|initializers)|lib/extras)/.*})
  watch('restart')
end


guard 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  #watch('spec/spec_helper.rb')  { "spec" }

  # Rails example
  watch(%r{^app/models/(.+)\.rb$})                           { |m| "spec/models/#{m[1]}_spec.rb" }
end
