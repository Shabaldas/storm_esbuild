# 3D STORM TEAM RAILS PROJECT
[![Maintainability](https://api.codeclimate.com/v1/badges/a28a0898c2e289240560/maintainability)](https://codeclimate.com/github/Shabaldas/storm_esbuild/maintainability)

[![Test Coverage](https://api.codeclimate.com/v1/badges/a28a0898c2e289240560/test_coverage)](https://codeclimate.com/github/Shabaldas/storm_esbuild/test_coverage)
### Requirements

FOR MACOS USER

  better to use rbenv

  - Ruby 3.1.3
  - Bundler - `gem install bundler`
  - Node.js 16.15.1 or higher - `brew install node@16`
  - Yarn 1.22.19 or higher - `brew install yarn` or [Install Yarn](https://yarnpkg.com/en/docs/install)
  - PostgreSQL - `brew install postgresql`
  - Libvips or Imagemagick - `brew install vips imagemagick`

  ### Setup
  ```bash
  git clone git@github.com:Shabaldas/storm_esbuild.git
  cd storm_esbuild
  ```
  ### Run the servers locally
  change your username and password for postgresuser in ```.env``` file
  push 
  ```bash
  bin/rails server -p 3000
  yarn build:css --watch
  yarn build --reload
  ```
  or
  ```foreman start```
  default port 3000
### FOR LINUX USER

### RUN SEED LOCAL
  ```
  bundle exec rails c

  DatabaseSeeds::Main.new.execute
  ```

### IF SOMETHING WENT WRONG
  1. Reset Database
    ```
    rails db:reset
    ```
  2. Go to rails console and run seed again
    ```
    bundle exec rails c

    DatabaseSeeds::Main.new.execute
    ```