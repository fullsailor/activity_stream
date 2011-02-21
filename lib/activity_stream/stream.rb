module ActivityStream
  
  class Stream
    
    # @param name [String] the name of the Stream
    # @param actor [ActivityStream::Actor]
    # @option opts [Symbol] :actors the method on the user that should return
    #   an Array of [ActorClass, actor_id] items.
    def initialize(name, actor, opts = {})
      @name = name
      @actor = actor
      @collection = initialize_collection(opts[:actors])
    end
    
    # @param reload [Boolean] Return to the database for new activities
    # @return the activities for the collection of actors
    def activities(reload = false)
      if @activities && !reload
        @activities 
      else 
        # Todo: Eager load the :actor
        @activities = ::Activity.by_actors(@collection)
      end
    end
    
    private
    
    def initialize_collection(actors)
      case actors
      when :self
        [@actor.class, @actor.id]
      when Symbol
        @actor.send(actors)
      else
        actors
      end
    end
    
  end
  
end