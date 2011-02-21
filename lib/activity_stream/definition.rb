require 'active_support/core_ext/array/extract_options'

module ActivityStream
  
  # Defines a type of activity. You don't actually interact with this class directly.
  class Definition

    attr_reader :name, :icon, :metadata, :template

    # @param proxy [ActivityStream::DefinitionProxy] A constructed proxy that
    #   will set the values for this Definition
    def initialize(proxy)
      @name = proxy[:name]
      @metadata = proxy[:metadata] || {}
      @template = proxy[:template] || 'activity'
      @icon = proxy[:icon] || 'activity_icon.png'
    end
    
    def icon_path
      'activity_stream/icons/%s' % self.icon
    end

    class << self 
      # @param definition [Definition] The definition to be made available
      # @return [Definition] Returns the registered definition
      def register(definition)
        definition = new(definition) if definition.is_a? DefinitionProxy
        if definition.is_a? Definition
          self.all << definition
          definition
        else
          false
        end
      end

      # List of registered definitions
      # @return [Array<ActivityStream::Definition>]
      # @example
      #   ActivityStream::Definition.all # => []
      #   Activity.define(:new_activity) do
      #     ...
      #   end
      #   ActivityStream::Definition.all
      def all
        @definitions ||= []
      end
      
      # Find a registered definition by its symbolic name
      # @param name [Symbol] the name to find
      # @return [ActivityStream::Definition]
      def find_by_name(name)
        unless definition = all.find{|definition| definition.name == name.to_sym}
          raise ActivityStream::UndefinedActivity, "Could not find a definition for `#{name}`"
        else
          definition
        end
      end
      
    end
    
  end
  
end
      
