class CreateBugs < ActiveRecord::Migration[6.0]
  def change
    create_table :bugs do |t|
      t.string :title
      t.string :description
      t.string :priority
      t.integer :estimated_days

      t.timestamps
    end
  end
end
