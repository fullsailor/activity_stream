module ActivityStream
  
  module ActivitiesHelper
    
    def render_activities(activities)
      return nil if activities.empty?
      activities.map do |activity|
        _partial_name = activity.template
        template = self.view_paths.find_template(%{activities/_#{_partial_name}}, :html)
        template.render_partial(self, activity)
      end.join('').html_safe
    end
  end
  
end