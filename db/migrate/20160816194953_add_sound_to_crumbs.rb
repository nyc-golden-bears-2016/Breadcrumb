class AddSoundToCrumbs < ActiveRecord::Migration[5.0]

      def self.up
      add_attachment :crumbs, :sound
    end

    def self.down
      remove_attachment :crumbs, :sound
    end
end
