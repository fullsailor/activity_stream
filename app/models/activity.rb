class Activity < ActiveRecord::Base
  
  # @param name [Symbol] (see ActivityStream::Definition#new)
  # @return [ActivityStream::Definition] the new definitions
  #
  def self.define(name, &block)
    @@definitions ||= []
    definition = ActivityStream::Definition.new(name)
    definition.instance_eval(&block)
    @@definitions << definitions
    definition
  end
  
end