module ActivityStream
  
  # @example Definition
  #   class User < ActiveRecord::Base
  #
  #     include ActivityStream::Actor
  #
  #     activity_stream(:friends, :actors => :friend_actors)
  #     
  #     def friend_actors
  #       friend_ids.map{|id| [User, id]}
  #     end
  # 
  #     def friend_ids
  #       # get friend ids
  #     end
  #
  #   end
  #
  # @example Usage
  #   @user.activity_stream(:friends) # => <ActivityStream::Stream>
  module Actor
    
    def self.included(base)
      base.extend(ClassMethods)
      base.class_eval do
        has_many :activities, :as => :actor
        activity_stream(:all, :actors => :activity_stream_actors)
      end
    end
    
    # @param name [Symbol] An activity identifer defined by Activity.define
    def create_activity(name)
      
    end

    # Creates and returns an ActivityStream::Stream for the predefined
    # list of actors. 
    # @param name [Symbol] The key of a defined activity stream
    def activity_stream(name)
      ActivityStream::Stream.new(name, self, self.class.defined_streams[name])
    end
    
    def activity_stream_actors
      self.class.all.map{|actor| [actor.class, actor.id]}
    end
    
    module ClassMethods
      
      # @attr_accessor defined_streams
      attr_accessor :defined_streams
      
      # Creates an activity_stream instance method that fetches 
      # all recent activity
      # 
      # @param name [Symbol] the name for the sub stream you wish to access
      # @option opts (see ActivityStream::Stream#new)
      def activity_stream(name, opts = {})
        self.defined_streams ||= {}
        self.defined_streams[name.to_sym] = opts
        return nil
      end
      
    end
    
  end
  
end
