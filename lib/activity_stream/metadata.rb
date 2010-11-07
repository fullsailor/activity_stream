require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/object/singleton_class'

module ActivityStream
  
  # Storage for an activities metadata.
  class Metadata
    
    attr_reader :data
    
    def initialize(definition_name)
      @definition_name = definition_name
      @data = {}
    end

    delegate :merge, :store, :to => :data

    def definition
      @definition ||= Definition.find_by_name(@definition_name)
    end
    
    def to_yaml_properties
      ["@data","@definition_name"]
    end

    def valid?
      # TODO: Check definition for required keys, and loop through the
      #       values in @data to see what is missing
      true
    end

    def method_missing(method_name)
      case method_name
      when *definition.metadata.keys
        @data[method_name]
      else
        super
      end
    end

    private
    
    def define_metadata_method(name)
      self.singleton_class.class_eval do
        define_method(name) do
          self.data[name]
        end
        define_method(:"#{name.to_s}=") do |value|
          self.data[name]= value
        end
      end
    end
    
  end
  
end
