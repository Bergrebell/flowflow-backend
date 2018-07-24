# Setup of DigitalOcean Droplet

1. Setup one-click application on DigitalOcean
2. Connect via SSH (if you can't connect and you are connected to a public network, try to connect from another network)

3. Install your ruby version on the server

  ```
  rmv install 2.5.1
  rvm --default use 2.5.1
  rmv use 2.5.1
  gem install bundler
  ```

4. Create a swap file (otherwise Nokogiri has troubles to build)

  ```
  dd if=/dev/zero of=/var/swap.img bs=1024k count=1000
  chmod 0600 /var/swap.img
  chown root:root /var/swap.img
  mkswap /var/swap.img
  swapon /var/swap.img
  echo '/var/swap.img       none    swap    sw      0       0' >> /etc/fstab
  ```

## Setup Capistrano for Deployment

1. Add to the `Gemfile` and run `bundle`

  ```
  gem 'capistrano'
  gem 'capistrano-rvm'
  gem 'capistrano-rails'
  gem 'capistrano3-puma'
  ```

2. Run `cap install`
3. Adapt `Capfile`

  ```
  require "capistrano/rvm"

  # For Rails projects
  require "capistrano/rails"

  # For Rails API projects
  require "capistrano/bundler"
  require "capistrano/rails/migrations"

  # Include puma
  require "capistrano/puma"
  install_plugin Capistrano::Puma
  install_plugin Capistrano::Puma::Nginx
  ```

4. Adapt `config/deploy/production.rb`

  ```
  server 'my.ip', user: 'rails', roles: %w[app db web]
  set :repo_url, 'my-git-ssh-url'

  set :deploy_to, '/home/rails/rails_project'
  set :linked_files, %w{config/master.key}
  ```

5. Login via SSH to the server
6. Create necessary directories on the server:

  ```
  mkdir /home/rails/rails_project/shared/config
  mkdir -p /home/rails/rails_project/shared/tmp/{sockets,pids,log}
  ```

7. Add your rails master key to the file `cat my-master-key > /home/rails/rails_project/shared/config/master.key`
8. Create the database on the server

  ```
  RAILS_ENV=production bin/rails db:create
  ```

9. Install the Puma and the Nginx configuration:

  ```
  cap production puma:config
  cap production puma:nginx_config # you might need to change the user to `root` to connect to the server
  ```

10. Remove `rails` nginx config from `/etc/nginx/sites-enabled`
11. Reload `systemctl reload nginx`

## SSL Certificate

Define `server_name mydomain.com` in your nginx configuration (otherwise certbot cannot update it automatically)
