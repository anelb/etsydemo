class RemoveFieldNameFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :recipiend, :string
  end
end
