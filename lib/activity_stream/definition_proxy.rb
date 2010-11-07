module ActivityStream
  
  # Provides a DSL to define an Activity. It is used in Activity.define
  class DefinitionProxy
    
    # @param name [Symbol] The name of the activity
    def initialize(name)
      @attributes = {
        :name => name.to_sym,
        :icon => 'activity_icon.png',
        :metadata => {},
        :template => 'activity'
      }
    end
    
    # Define the activity's icon
    # @param filename [String] the icon's name inside of the 
    #   `public/images/activity_stream/icons` directory
    def icon(filename)
      @attributes.store(:icon, filename)
    end
    
    # Define metadata for the activity
    # @param name [Symbol] the unique name for the metadata attribute
    # @option opts :default The default value for that metadata
    # @option opts [Boolean] :required (false) Mark this metadata as required
    def metadata(*args)
      opts = args.extract_options!
      args.each do |name|
        self.add_metadata(name, opts)
      end
    end
    
    # Define a custom template 
    # @param name [String] the name of the template for this Activity.
    #   Should be located in `app/views/activities/*`
    def template(template_name)
      @attributes.store(template_name)
    end
    
    delegate :[], :to => :@attributes
    
    def add_metadata(name, opts = {})
      @attributes[:metadata][name] = opts
    end
    
  end
  
end