class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |p|
      p.text :personname
      p.text :content
      p.timestamps
    end
  end
end
