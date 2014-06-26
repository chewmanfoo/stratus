class AddCanCreateReportsToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :creates_reports, :boolean
    add_column :groups, :views_reports, :boolean
  end
end
