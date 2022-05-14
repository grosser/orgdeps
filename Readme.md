List private inter project dependencies (rubygems + chef) and project badge generator.

 - see what a project depends on
 - see what depends on a project

https://orgdeps.herokuapp.com

Uses github auth to look through Gemfile/Gemfile.lock/metadata.rb and builds a dependecny list.

Powered by [repo_dependency_graph](https://github.com/grosser/repo_dependency_graph)

Use `EDIT_BLOCKED` to prevent any kind of editing (prevents injection/bug exploitation etc).

### Development

```
... install ruby + bundler ...
... fill out .env ...
bundle install
rails s
```

### Test

```
bundle exec rake ci
```

### TODO
 - airbrake + reset on deploy
 - nice screenshot (https://orgdeps.herokuapp.com/organizations/premailer/repositories)
 - auto-fetch when new token is added
 - travis cron

License: MIT
