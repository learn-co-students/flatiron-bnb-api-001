---
tags: rails, full application, API, controllers, json, respond_to, WIP
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

Let's begin! Be sure to <strong>read through this README</strong>. As always, take it slow and <strong>work together</strong>. :couple::two_women_holding_hands::two_men_holding_hands:

## Configuration

There are a few ways to approach our initial codebase organization: we can keep our API and web controllers separate (where we would have two controllers, one that inherits from ActiveRecord::Base and one that inherits from ActiveRecord::API), or we can keep them together, in a way that's pretty similar to what we've been building so far. For our app, we're going to keep them together. However, when a client makes an HTTP request to our server, we want it to have the subdomain "api" (for eg: http://api.example.com/listings). We will need to organize our routes in a block like so:

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

Any additional requests our application could respond to would be via filters (eg, get all users that are hosts, get all reservations that are pending, etc).

## Active Model Serializers

We're going to use the [Active Model Serializers gem](https://github.com/rails-api/active_model_serializers) which makes sure that our objects are returned in the proper JSON format.

## Controllers

Our controller methods will look not-unlike how we've been writing them when we were building just web applications. Use the tests as guidance for which methods to write and which params could be used as filters on requests.

### `respond_to`

We want to build our API to be able handle multiple response formats. Web applications want HTML, mobile phones want JSON, something else might want XML. We can respond with many other types, but let's just focus on JSON right now. (If you want to see all of the types Rails knows about, go into the `rails console` and type `Mime::SET`.)

We're going to build with the mindset of expansion, so we'll be using the `respond_to` method. You may recall seeing this within our controller create and update methods before, when we scaffolded our apps back in the day (life was so much easier back then). No scaffolding allowed in this lab! :hand:

What the `respond_to` method does is allow our controller methods (index, show, etc) to <strong>serve</strong> back a response in different formats (JSON, HTML, XML, etc) to the clients requests.

A `respond_to` block looks something like this:

```ruby
def index
  @post = Post.find(params[:id])
  respond_to do |format|
    format.json { render json: @post, status: 200 }
  end
end
```

Let's break down what's happening with the JSON format. If the client wants `format.json`, render the `@post` object as json, with a response status of 200.

## Resources
