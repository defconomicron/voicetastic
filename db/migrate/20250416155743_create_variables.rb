class CreateVariables < ActiveRecord::Migration[8.0]
  def change
    create_table :variables do |t|
      t.string :name
      t.string :value

      t.timestamps
    end

    add_index :variables, :name
  end
end
