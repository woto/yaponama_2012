# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Yaponama2012::Application.load_tasks

namespace :test do
  desc "Run tests for rake"
  Rails::TestTask.new(:rake) do |t|
    t.libs << "test"
    t.pattern = 'test/rake/**/*_test.rb'
  end
end

namespace :catalog do
  Rails::TestTask.new(:egrgroup_ru_grab) do |t|
    t.libs << "test"
    t.pattern = 'catalog/egrgroup_ru_grab.rb'
  end
end

Rake::Task[:test].enhance { Rake::Task["test:rake"].invoke }
