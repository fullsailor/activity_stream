module ActivityStream
  
  # Generic ActivityStream Error class
  class ActivityStreamError < StandardError
  end
  
  # An ActivityStream::UndefinedActivity exception is raised when you attempt
  # to create an activity of an undefined kind.
  # @example
  #   ActivityStream::Definition.definitions # => []
  #   @actor.create_activity(:bogus_activity) # raises UndefinedActivity
  #
  class UndefinedActivity < ActivityStreamError
  end
  
end