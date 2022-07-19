
Tasker Project
-----------

Simple application for tasks management including tasks assigning(soon) and different tasks statuses.  
Project available on https://tasker-tm-application.herokuapp.com/

System Dependencies
-------------------

Project was created using:

- Ruby 3.0.0
- Rails 7.0.3
- PostgreSQL
- Node 14.19.3

Project Install
-------------------
```shell
git clone git@github.com:omelinb/Tasker.git
bundle install
bundle exec rails db:create
bundle exec rails db:migrate
```

API
---

`/api/v1/tasks/:status` - `:status` param can be one of the next values: new, in_progress, completed, canceled
