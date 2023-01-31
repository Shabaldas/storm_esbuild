# 3D STORM TEAM RAILS PROJECT

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