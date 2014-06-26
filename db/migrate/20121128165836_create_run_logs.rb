class CreateRunLogs < ActiveRecord::Migration
  def change
    create_table :run_logs do |t|
      t.text :log
      t.string :type

      t.timestamps
    end
  end
end
