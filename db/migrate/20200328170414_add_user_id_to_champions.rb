class AddUserIdToChampions < ActiveRecord::Migration[5.2]
  def change
    add_column :champions, :user_id, :integer
  end
end
