class CreateEsrWorks < ActiveRecord::Migration
  def change
    create_table :esr_works do |t|
      t.string :name

      t.timestamps
    end
  end
end
