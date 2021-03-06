class CreateElements < ActiveRecord::Migration
  def self.up
    create_table :elements do |t|
      t.string :name
      t.integer :position
      t.string :ancestry
      t.integer :ancestry_depth, :default => 0

      # polymorphic
      t.integer :attachable_id
      t.string :attachable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :elements
  end
end
