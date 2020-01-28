class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :body

      t.belongs_to :author, foreign_key: { to_table: :users }, index: true
      t.belongs_to :post, foreign_key: true, index: true

      t.timestamps
    end
  end
end
