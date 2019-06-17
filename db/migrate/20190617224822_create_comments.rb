class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |c|
      c.text :personname
      c.text :content
      c.integer :post_id

      c.timestamps
    end
  end
end
