require 'active_support/core_ext/array/extract_options'

module ActivityStream
  
  def definitions
    @@definitions ||= []
  end
  
  class Definition

    attr_reader :name
    
    # @param name [Symbol] the unique name of the Activity 
    def initialize(name)
      @name = name.to_sym
      @metadata = {}
    end
    
    # @param filename [String] the icon's name inside of the 
    #  `public/images/activity_stream/icons` directory
    def icon(filename)
      @icon = filename
    end
    
    # @overload metadata
    #   @return [Hash] A hash of defined metadata
    # @overload metadata(name, opts = {})
    #   @param name [Symbol] the unique name for the metadata attribute
    #   @option opts :default The default value for that metadata
    def metadata(*args)
      if args.empty?
        @metadata
      else
        opts = args.extract_options!
        @metadata[args.first.to_sym] = opts
      end
    end
    
    #
    def template
      'activity'
    end
    
    class << self 
      # @param definition [Definition] The definition to be made available
      # @return [Definition] Returns the registered definition
      def register(definition)
        self.all << definition
        definition
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
        @@definitions ||= []
      end
      
      # Find a registered definition by its symbolic name
      # @param name [Symbol] the name to find
      # @return [ActivityStream::Definition]
      def find_by_name(name)
        unless definition = all.find{|d| d.name == name.to_sym}
          raise ActivityStream::UndefinedActivity, "Could not find a definition for `#{name}`"
        else
          definition
        end
      end
      
    end
    
  end
  
end
      
