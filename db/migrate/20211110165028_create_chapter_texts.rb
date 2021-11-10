class CreateChapterTexts < ActiveRecord::Migration[6.1]
  def change
    create_table :chapter_texts do |t|
      t.integer :position

      t.belongs_to :chapter
      t.belongs_to :text

      t.timestamps
    end
  end
end
