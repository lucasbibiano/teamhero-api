web: bash -c '/home/deployer/.rvm/gems/ruby-2.3.0/wrappers/bundle exec rackup -p 8000'
worker: bash -c '/home/deployer/.rvm/gems/ruby-2.3.0/wrappers/bundle exec sidekiq -r ./environment.rb'
