module ActivityStream
  
  class Stream
    
    # @param name [String] the name of the Stream
    # @param actor [ActivityStream::Actor]
    # @option opts [Symbol] :actors (:activity_stream_actors) the method on
    #   the user that should return an Array of [ActorClass, actor_id] items.
    def initialize(name, actor, opts = {})
      @name = name
      @actor = actor
      @collection = initialize_collection(opts[:actors])
    end
    
    def activities
      @activities ||= Activity.by_actors(@collection)
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