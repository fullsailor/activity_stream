module ActivityStream
  
  # @author Andrew Smith
  module Actor
    
    def self.include(klass)
      klass.extend(ClassMethods)
      klass.class_eval do
        has_many :activities
      end
    end
    
    # @param name [Symbol] An activity identifer defined by Activity.define
    def create_activity(name)
      
    end
    
    module ClassMethods
      

      # Creates an activity_stream instance method that fetches 
      # all recent activity
      # 
      # @param name [Symbol] the name for the sub stream you wish to access
      # @option opts [Symbol] :actors (:activity_stream_actors) the method on
      #   the user that should return an Array of [ActorClass, actor_id] items.
      def activity_stream(name = :all, opts = {})
        @@defined_streams ||= {}
        @@defined_streams[name.to_sym] = opts
        define_method
      end
    end
    
  end
  
end