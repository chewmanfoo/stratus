class ChangeBodyOnSuggestionsToText < ActiveRecord::Migration
  def up
    change_column :suggestions, :body, :text
  end

  def down
    change_column :suggestions, :body, :string
  end
end
