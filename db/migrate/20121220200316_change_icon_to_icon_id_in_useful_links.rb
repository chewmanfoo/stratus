class ChangeIconToIconIdInUsefulLinks < ActiveRecord::Migration
  def up
    remove_column :useful_links, :icon
    add_column :useful_links, :icon_id, :integer
  end

  def down
  end
end
