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
    
    
      create_table :users do |t|
        t.string :name
      end
      
    
  end

  def self.down
    
      drop_table :users
    
    
    drop_table :activities
    
  end
end
