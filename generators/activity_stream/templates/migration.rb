class CreateActivityStreamTables < ActiveRecord::Migration
  def self.up
    
    create_table :activities do |t|
      t.integer :actor_id
      t.string :actor_type
      t.string :kind
      t.text :metadata
      t.datetime :occurred_at
    end
    
    add_index :activities, [:actor_id, :actor_type]
    
    <% unless has_users %>
      create_table :users do |t|
        t.string :name
      end
      
    <% end %>
  end

  def self.down
    <% unless has_users %>
      drop_table :users
    <% end %>
    
    drop_table :activities
    
  end
end
