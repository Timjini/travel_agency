class AddTranslationsToTasks < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :translations, :jsonb
  end
end
