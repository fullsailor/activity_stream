module ActivityStream
  
  class Activity < ActiveRecord::Base
  
    belongs_to :actor, :polymorphic => true
  
    before_save :ensure_occurred_at_set
  
    # @param name [Symbol] (see ActivityStream::Definition#new)
    # @return [ActivityStream::Definition] the new definitions
    #
    def self.define(name, &block)
      definition = ActivityStream::DefinitionProxy.new(name)
      definition.instance_eval(&block)
      ActivityStream::Definition.register(definition)
    end
  
    def self.new_with_name_and_metadata(name, metadata = {})
      new(:kind => name.to_s, :metadata => metadata)
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
  
    delegate :template, :icon_path, :to => :definition
  
    def metadata
      self[:metadata] ||= ActivityStream::Metadata.new(self[:kind])
    end
  
    def metadata=(new_data = {})
      new_data = new_data.presence || {}
      occurred_at = new_data.delete(:occurred_at)
      new_data.each do |key, value|
        metadata.store(key, value)
      end
    end
  
    def definition
      ActivityStream::Definition.find_by_name(self[:kind])
    end
  
    def kind=(val)
      write_attribute(:kind, val.to_s)
    end
  
    def kind
      read_attribute(:kind).to_sym
    end
  
    private
  
    def ensure_occurred_at_set
      self.occurred_at ||= Time.now
    end

  end
end
