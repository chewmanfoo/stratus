class ChangeVersionOnEsrPackageProblems < ActiveRecord::Migration
  def up
    change_table :esr_package_problems do |t|
      t.rename :version, :trusted_version
      t.string :target_version
    end
  end

  def down
  end
end
