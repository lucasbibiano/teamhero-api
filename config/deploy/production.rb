set :stage, :production

# Replace 127.0.0.1 with your server's IP address!
server '104.236.11.46', user: 'deployer', roles: %w{web app}
