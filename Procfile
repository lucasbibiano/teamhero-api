web: bash -c '/home/deployer/.rvm/gems/ruby-2.3.0/bin/rackup -p 8000'
worker: bash -c '/home/deployer/.rvm/gems/ruby-2.3.0/bin/rackup exec sidekiq -r ./environment.rb'
