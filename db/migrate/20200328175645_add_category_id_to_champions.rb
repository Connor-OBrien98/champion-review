class AddCategoryIdToChampions < ActiveRecord::Migration[5.2]
  def change
    add_column :champions, :category_id, :integer
  end
end
