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
    
  end
  
end
      