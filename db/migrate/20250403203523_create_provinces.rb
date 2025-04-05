class CreateProvinces < ActiveRecord::Migration[8.0]
  def change
    create_table :provinces, id: :uuid do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :provinces, :slug, unique: true
  end
end
