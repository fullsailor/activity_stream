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
    
    # @param filename [String] the icon's name inside of the 
    #  `public/images/activity_stream/icons` directory
    def icon(filename)
      @icon = filename
    end
    
    # @param definition [Definition] The definition to be made available
    # @return [Definition] Returns the registered definition
    def self.register(definition)
      ActivityStream.definitions << definition
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
    def self.all
      @@definitions ||= []
    end
    
  end
  
end
      