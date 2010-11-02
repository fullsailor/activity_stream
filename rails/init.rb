require 'activity_stream'

config.to_prepare do
  ApplicationController.helper(ActivityStream::ActivitiesHelper)
end