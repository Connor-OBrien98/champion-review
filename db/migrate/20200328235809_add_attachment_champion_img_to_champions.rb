class AddAttachmentChampionImgToChampions < ActiveRecord::Migration[5.2]
  def self.up
    change_table :champions do |t|
      t.attachment :champion_img
    end
  end

  def self.down
    remove_attachment :champions, :champion_img
  end
end
