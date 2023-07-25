# Development setup

At first, make a `.env` settings from `.example`s.

#### Backend
- Install Ruby (version defined in `.ruby-version` file) via [rbenv](https://github.com/rbenv/rbenv)
- Install Postgres 14
- Install Bundler (`gem install bundler`)
- `.env`: check `PG_HOST` and add `PG_USER`, `PG_PASSWORD`, `REDIS_URL` if needed
- `bundle install`
- `bundle exec rake db:setup`
- `bundle exec rails s`