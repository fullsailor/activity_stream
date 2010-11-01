require File.expand_path(File.dirname(__FILE__) + "/lib/insert_commands.rb")
# require File.expand_path(File.dirname(__FILE__) + "/lib/rake_commands.rb")

class ActivityStreamGenerator < Rails::Generator::Base
  
  def manifest
    record do |m|
      
      m.directory(File.join('app','models','activities'))
      m.template('example_activity.rb', 'app/models/activities/example_activity.rb')
      
      user_model = 'app/models/user.rb'
      if File.exists?(user_model)
        m.insert_into(user_model, "include ActivityStream::Actor")
      else
        m.directory(File.join('app', 'models'))
        m.file('user.rb', user_model)
      end
      
      m.migration_template('migration.rb',
                           'db/migrate',
                           :migration_file_name => 'create_activity_stream_tables',
                           :assigns => {:has_users => ActiveRecord::Base.connection.table_exists?(:users)})
      
    end
  end
  
end