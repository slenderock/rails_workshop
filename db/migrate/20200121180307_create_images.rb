class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.belongs_to :imageable, polymorphic: true

      t.jsonb :image_data, null: false, default: {}

      t.timestamps
    end
  end
end
