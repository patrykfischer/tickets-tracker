# README

Tickets tracker

It's application for tracking ticket(simple jira).

Start here:
  - run bundler (bundle install)
  - run redis
  - run sidekiq
  - run migration (bundle exec rake db:migrate)
  - run server (rails s)

You can use this app only via API. For example:
  - POST '/users' - will create user with email and name
    {
      email: 'Bestben@ben.com',
      name: 'Ben',
    }

  - Response:
    {
      id: 1,
      name: "Ben",
      email: "bestben@ben.com",
      created_at: "2017-09-19T21:26:18.130Z",
      updated_at: "2017-09-19T21:26:18.130Z"
    }

You can also:
  - update user name
  - get all user tickets
  - create ticket
  - change status of ticket (mark as done etc.)

More you can find in code! Have fun!
