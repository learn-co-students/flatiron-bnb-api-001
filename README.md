---
tags: rails, full application, API, controllers, json, respond_to, jbuilder
language: ruby
resources: 1
---

# Flatiron-bnb: Building an API

Many of you have been consuming APIs for various side projects, but instead of being just the consumer, we're going to be building one ourselves.

Imagine you've built a site that allows hosts to list their apartments for short term stays, and other users (guests) can book those listings and then review them after their stay (sound familiar?). This sounds like an awesome, useful website, but what if we wanted to build an accompanying iPhone or Android app? It would be inefficient to rewrite the entire program for those platforms. Data would get lost, and our website and mobile apps would soon turn into completely different applications and user experiences.

That's where an API comes in handy. So many applications (think Github, Twitter, Meetup.com, Etsy, Airbnb) are actually architectured as APIs, because it's easy then for multiple clients (like mobile apps, the front-end framework of their website, developers building programs with the data) to consume and work with the application's data.

Let's begin! Be sure to <strong>read through this README</strong>. As always, take it slow and <strong>work together</strong>. :couple::two_women_holding_hands::two_men_holding_hands:

## Configuration

There are a few ways to approach our initial codebase organization: we can keep our API and web controllers separate (where we would have two controllers, one that inherits from ActiveRecord::Base and one that inherits from ActiveRecord::API), or we can keep them together, in a way that's pretty similar to what we've been building so far. For our app, we're going to keep them together.

## Routes

Therefore, in our application, the following will be our resources in our `routes.rb`:

* listings
* users
* cities
* neighborhoods
* reservations
* reviews

Any additional requests our application could respond to would be via filters (eg, get all users that are hosts, get all reservations that are pending, etc).

Let the tests guide you as to which routes should be included/excluded. It's best practices to be more exclusive with which routes we want available. We can limit which resources are available by passing either `only:` or `except:` arguments.

## Controllers

Our controller methods will look not-unlike how we've been writing them when we were building just web applications. Use the tests as guidance for which methods to write and which params could be used as filters on requests.

### `respond_to`

We want to build our API to be able handle multiple response formats. Web applications want HTML, mobile phones want JSON, something else might want XML. We can respond with many other types, but let's just focus on JSON right now. (If you want to see all of the types Rails knows about, go into the `rails console` and type `Mime::SET`.)

We're going to build with the mindset of expansion, so we'll be using the `respond_to` method. You may recall seeing this within our controller create and update methods before, when we scaffolded our apps back in the day (life was so much easier back then). No scaffolding allowed in this lab! :hand:

What the `respond_to` method does is allow our controller methods (index, show, etc) to <strong>serve</strong> back a response in different formats (JSON, HTML, XML, etc) to the clients' requests.

A `respond_to` block looks something like this:

```ruby
def show
  @post = Post.find(params[:id])
  respond_to do |format|
    format.json
    format.xml
  end
end
```

`format.json` renders our corresponding jbuilder view.

### `jbuilder`

We're going to use [jbuilder](https://github.com/rails/jbuilder), a Ruby DSL built into Rails that allows us to format our JSON response to include whatever we want. For rendering one listing given id as a parameter, for example, we would format our response here: `views/listings/show.json.jbuilder`. We want our response in JSON to look something like this:

```ruby
{
  {
    id: 1,
    address: "123 Main Street",
    listing_type: "private room",
    # etc...
  },
}
```

Using jbuilder, we can determine how our data will look by assigning it in our jbuilder file:

```ruby
json.id @listing.id
json.address @listing.address
json.listing_type @listing.listing_type
# etc...
```

Because jbuilder is a <strong>Ruby</strong> DSL, we can write plain ol' Ruby in these files as well. We can write conditionals to only return json attributes of an object if say, the attribute isn't empty. For example, in our `show.json.jbuilder` for users, we might only want to display a user's listings only if that user is a host:

```ruby
if @user.host = true
  json.listings @user.listings
end
```

## Bonuses

* Be able to query/filter users by host status. This will be challenging because the column type is a boolean and JSON does not know how to automatically handle booleans. One strategy would be to convert the params values to boolean in a `before_action` callback.

## Super bonuses

* Turn the class methods for city and neighborhood into get requests/methods.

## Resources
* [Rendering JSON responses using Jbuilder](http://www.multunus.com/blog/2014/03/using-jbuilder-instead-erb-rendering-json-response/)