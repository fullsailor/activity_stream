# ActivityStream (early alpha) #

![unmaintained](http://img.shields.io/badge/status-unmaintained-red.png)

Activity Stream provides a simple DSL to define, create,
and retrieve user activities.

## Installation ##

Add it to your Gemfile:

    gem 'activity_stream'
   
Run the generator:

    script/generate activity_stream
    
And migrate the database:

    rake db:migrate

## Usage ##

### Defining Activities ###

In `config/initializers/activity_stream.rb`:

    Activity.define(:example_action) do
      metadata(:target, :default => :actor)
      metadata(:referrer)
      icon('example_activity_icon.png')
    end

### Extending User ###

In your User model:

    class User < ActiveRecord::Base
    
      include ActivityStream::Actor
      
      def followed_actors
        [[User, 13], [User, 14], [Page, 9]]
      end
      
    end

### Retrieving Activities ###

In your dashboard controller:

    @activity_stream = current_user.activity_stream

### Creating Activies ###

When you want to create an activity:

    current_user.publish_activity(:example_action,
                                 :target => @friend,
                                 :referrer => @referrer)


## Notes ##

Currently designed for Rails 2.3.10, because the project
that prompted its creation is that version. I can't guarantee
that it will work in any other version of Rails.

However, I do have other projects, that are Rails 3, that will
benefit from a Rails 3 compatible version of activity_stream.
Be on the lookout for updates!


