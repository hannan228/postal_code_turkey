class CreateNeighborhoods < ActiveRecord::Migration[8.0]
  def change
    create_table :neighborhoods, id: :uuid do |t|
      t.string :name
      t.references :district, null: false, foreign_key: true, type: :uuid
      t.references :province, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
