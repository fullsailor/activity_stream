class Activity < ActiveRecord::Base
  
  belongs_to :actor, :polymorphic => true
  
  # @param name [Symbol] (see ActivityStream::Definition#new)
  # @return [ActivityStream::Definition] the new definitions
  #
  def self.define(name, &block)
    definition = ActivityStream::Definition.new(name)
    definition.instance_eval(&block)
    ActivityStream::Definition.register(definition)
  end
  

  # @param actors [Array] An array of [ActorClass, actor_id] sets
  #   or [ActorClass, [actor_id, actor_id, actor_id...]
  #
  named_scope :by_actors, lambda { |actors|
    if actors.first.is_a?(Array)
      conditions_with_polymorphic_actors(actors)
    elsif actors.first.is_a?(Class)
      {:conditions => {:actor_id => actors.last, :actor_type => actors.first}}
    else
      {} # Not sure what to do here.
    end
  }
  
  private
  
  def conditions_with_polymorphic_actors(actors)
    conditions = actors.map do |(actor_type, actor_id)|
      "(activities.actor_id = #{actor_id.to_param} AND activities.actor_type = '#{actor_type.to_param}')"
    end
    {:conditions => conditions.join(' OR ') }
  end
  
end