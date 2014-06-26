class CreateEsrPackageProblems < ActiveRecord::Migration
  def change
    create_table :esr_package_problems do |t|
      t.integer :environment_sync_report_id
      t.integer :package_id
      t.string :conflict

      t.timestamps
    end
  end
end
