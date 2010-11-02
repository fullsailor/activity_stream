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
  
  named_scope :in_reverse_chronological_order, :order => 'occurred_at DESC'
  
  named_scope :in_chronological_order, :order => 'occurred_at ASC'

  # @param actors [Array] An array of [ActorClass, actor_id] sets
  #   or [ActorClass, [actor_id, actor_id, actor_id...]
  #
  named_scope :by_actors, lambda { |actors|
    if actors.first.is_a?(Array)
      conditions = actors.map do |(actor_type, actor_id)|
        %{("activities"."actor_id" = #{actor_id.to_param} AND "activities"."actor_type" = '#{actor_type.to_param}')}
      end
      {:conditions => conditions.join(' OR ') }
    elsif actors.first.is_a?(Class)
      {:conditions => {:actor_id => actors.last, :actor_type => actors.first.to_param}}
    else
      {} # Not sure what to do here.
    end
  }
  
  serialize :metadata, ActivityStream::Metadata
  
  def metadata
    self[:metadata] ||= ActivityStream::Metadata.new(self[:kind])
  end
  
  def definition
    ActivityStream::Definition.all.find{|d| d.name == self[:kind].to_sym}
  end

end