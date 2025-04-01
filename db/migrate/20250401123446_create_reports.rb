class CreateReports < ActiveRecord::Migration[8.0]
  def change
    create_table :reports do |t|
      t.references :department, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :uploaded_at
      t.text :comments

      t.timestamps
    end
  end
end
