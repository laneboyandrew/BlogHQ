class CreateFeedback < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |f|
      f.text :username
      f.text :textarea

      f.timestamps
    end
  end
end
