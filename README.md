# README

Please follow the intructions above to launch the app

## Dependencies

* Rails 6.1.6.1
* ruby 2.7.4
* Yarn 1.22.11
* Node v14.16.1


## Fetch the repo

* git clone git@github.com:adetkr/opening-hours-app.git


## Launch the app

```
bundle install
yarn install
rails db:drop db:create db:migrate db:seed
rails s
```

