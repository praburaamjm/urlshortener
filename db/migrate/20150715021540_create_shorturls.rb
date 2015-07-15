class CreateShorturls < ActiveRecord::Migration
  def change
    create_table :shorturls do |t|
      t.string :fullurl
      t.string :shorturl
      t.timestamps null: false
    end
  end
end
