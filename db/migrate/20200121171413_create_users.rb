class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.string :email, unique: true, null: false

      t.datetime :last_sign_in_at
      t.datetime :current_sign_in_at

      t.integer :sign_in_count, default: 0, null: false

      t.timestamps
    end
  end
end
