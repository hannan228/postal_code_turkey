class CreatePostalCodes < ActiveRecord::Migration[8.0]
  def change
    create_table :postal_codes, id: :uuid do |t|
      t.references :neighborhood, null: false, foreign_key: true, type: :uuid
      t.string :code

      t.timestamps
    end
  end
end
