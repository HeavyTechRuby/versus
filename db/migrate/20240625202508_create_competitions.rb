class CreateCompetitions < ActiveRecord::Migration[7.1]
  def change
    create_table :competitions do |t|
      t.string :name, null: false
      t.string :description
      t.bigint :author_id, null: false
      t.timestamps
    end

    add_foreign_key :competitions, :users, column: :author_id
    add_index :competitions, :author_id
  end
end
