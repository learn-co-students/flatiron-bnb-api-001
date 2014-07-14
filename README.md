---
tags: rails, full application, API, controllers, WIP
language: ruby
unit: rails
module: ??
level: advanced
resources: 0
---

# Flatiron-bnb: Building an API

Many of you have been consuming APIs for various side projects, but instead of being just the consumer of awesome data structures, we're going to be building one ourselves.

Imagine you've got a site that allows hosts to list their apartments for short term stays, and other users (guests) can book those listings and then review them after their stay (sound familiar?). This sounds like an awesome, useful website, but what if we wanted to build an accompanying iPhone or Android app? It would be inefficient to rewrite the entire program for those platforms. Data would get lost, and our website and mobile apps would soon turn into completely different applications and user experiences.

That's where an API comes in handy. So many sites (think Github, Twitter, Meetup.com, Etsy, Airbnb) are actually architectured as APIs, because it's easy then for multiple clients (like mobile apps, the front-end framework of their website, developers building programs with the data) to consume and work with an application's data.

<strong>Before anything</strong>, note that when you generate models, controllers, etc, be sure to include this option, so that it skips tests (which we already have): `--no-test-framework`

## Configuration

There are a few ways to approach the initial codebase organization: we can keep our API and web controllers separate, or we can keep them together. For our app, we're going to keep them together. However, when a client makes an HTTP request to our server, we want it to have the subdomain "api" (for eg: http://api.example.com/listings). We will need to organize our routes in a block like so:

```ruby
  constraints subdomain: 'api' do 
    #routes here
  end
```

In our application, the following will be our resources:

* listings
* users
* cities
* neighborhoods (only show and index)
* reservations (only show and index)
* reviews (nested under reservations)

Any additional queries will be via filters (eg, all users that are hosts, reservations that are pending, etc).

## Active Model Serializers

We're going to use the [Active Model Serializers gem](https://github.com/rails-api/active_model_serializers) which makes sure that our objects are returned in the proper JSON format.

## Controllers

### `respond_to`

We want to build our API to handle two different types of responses from clients, JSON and HTML.

## Resources
