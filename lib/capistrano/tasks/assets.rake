
module Capistrano
  class FileNotFound < StandardError
  end
end

namespace :deploy do
  desc 'Normalize asset timestamps'
  task :normalize_assets => [:set_rails_env] do
  end

  desc 'Compile assets'
  task :compile_assets => [:set_rails_env] do
  end

  desc 'Cleanup expired assets'
  task :cleanup_assets => [:set_rails_env] do
  end

  desc 'Clobber assets'
  task :clobber_assets => [:set_rails_env] do

  end

  desc 'Rollback assets'
  task :rollback_assets => [:set_rails_env] do
  end

  after 'deploy:updated', 'deploy:compile_assets'
  after 'deploy:updated', 'deploy:cleanup_assets'
  after 'deploy:updated', 'deploy:normalize_assets'
  after 'deploy:reverted', 'deploy:rollback_assets'

  namespace :assets do
    task :precompile do
    end

    task :backup_manifest do
    end

    task :restore_manifest do
    end
  end
end

# we can't set linked_dirs in load:defaults,
# as assets_prefix will always have a default value
namespace :deploy do
  task :set_linked_dirs do
  end
end

after 'deploy:set_rails_env', 'deploy:set_linked_dirs'

namespace :load do
  task :defaults do
  end
end
