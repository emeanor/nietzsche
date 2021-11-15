class ChangeEditionsAddEditorIntro < ActiveRecord::Migration[6.1]
  def change
    add_column :editions, :editor_intro, :text
  end
end
