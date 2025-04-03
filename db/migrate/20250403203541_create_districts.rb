class CreateDistricts < ActiveRecord::Migration[8.0]
  def change
    create_table :districts, id: :uuid do |t|
      t.references :province, null: false, foreign_key: true, type: :uuid
      t.string :name

      t.timestamps
    end
  end
end
