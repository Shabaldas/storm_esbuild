# 3D STORM TEAM RAILS PROJECT
[![Maintainability](https://api.codeclimate.com/v1/badges/a28a0898c2e289240560/maintainability)](https://codeclimate.com/github/Shabaldas/storm_esbuild/maintainability)

[![Test Coverage](https://api.codeclimate.com/v1/badges/a28a0898c2e289240560/test_coverage)](https://codeclimate.com/github/Shabaldas/storm_esbuild/test_coverage)
### Requirements

FOR MACOS USER

  better to use rbenv

  - Ruby 3.2.0
  - Bundler - `gem install bundler`
  - Node.js 16.15.1 or higher - `brew install node@16`
  - Yarn 1.22.19 or higher - `brew install yarn` or [Install Yarn](https://yarnpkg.com/en/docs/install)
  - PostgreSQL - `brew install postgresql`
  - Libvips or Imagemagick - `brew install vips imagemagick`

  ### Setup
  ```bash
  git@github.com:Shabaldas/storm_esbuild.git
  cd storm_esbuild
  ```
  ### Run the servers locally
  ```bash
  foreman start -f Procfile.dev
  # OR
  bin/rails server -p 3000
  yarn build:css --watch
  yarn build --reload
  ```
FOR LINUX USER