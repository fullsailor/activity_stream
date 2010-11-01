module ActivityStream
  
  # @author Andrew Smith
  class Definition
    
    # @param name [Symbol] the unique name of the Activity 
    def initialize(name)
      @name = name.to_sym
      @metadata = {}
    end
    
    # @param name [Symbol] the unique name for the metadata attribute
    # @option opts :default The default value for that metadata
    def metadata(name, opts = {})
      @metadata[name.to_sym] = opts
    end
    
    # @param filename [String] the icon's name inside of the 
    #  `public/images/activity_stream/icons` directory
    def icon(filename)
      @icon = filename
    end
    
    # @param definition [Definition] The definition to be made available
    # @return [Definition] Returns the registered definition
    def self.register(definition)
      @@definitions ||= []
      @@definitions << definition
      definition
    end
  end
  
end
      