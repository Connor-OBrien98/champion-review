class AddChampionIdToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :champion_id, :integer
  end
end
