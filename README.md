# Fonda

Rental Geek API, First Generation

[ ![Codeship Status for RentalGeek/fonda](https://codeship.io/projects/9acc2d90-161e-0132-aeec-4a49cf4e7c40/status)](https://codeship.io/projects/33799)

## Prerequisites

You will need the following things properly installed on your computer.

* [Git](http://git-scm.com/)
* [Ruby](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-on-ubuntu-12-04-lts-precise-pangolin-with-rvm)
* [Rails](http://rubyonrails.org/download/)

## Getting Fonda setup locally

**1. Clone fonda application from GitHub**
-  $ `git clone https://github.com/RentalGeek/fonda.git`

**2. Now move to the fonda directory and run the following commands:**
-   $ `source ~/.rvm/scripts/rvm`
-   $ `rvm use ruby-2.1.2`
-   $ `rvm gemset create fonda`
-   $ `rvm use ruby-2.1.2@fonda`
-   $ `sudo apt-get install postgresql`
-   $ `sudo apt-get install libpq-dev`
-   $ `gem install pg -v '0.17.1'`
-   $ `bundle install`

**3. Set up database**
-   $ `rake db:create` _# postgres database should be installed on the machine_
-   $ `rake db:migrate` _# For errors see https://github.com/RentalGeek/fonda/wiki/Initial-Notes_

**4. Run Rails server**
-   $ `rails server` _# to run rails server_

# RentalGeek
