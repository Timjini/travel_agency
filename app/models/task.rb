class Task < ApplicationRecord
  include Translatable

   after_initialize do
    self.translations ||= {}
    puts "Initialized translations: #{self.translations.inspect}"
  end
  validates :name, presence: true

  # after_create_commit { broadcast_prepend_to "task" }
end
