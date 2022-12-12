class AddColumnToBug < ActiveRecord::Migration[6.0]
  def change
    add_column :bugs, :status, :string
    add_column :bugs, :assigned_to, :integer
  end
end
