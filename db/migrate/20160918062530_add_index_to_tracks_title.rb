class AddIndexToTracksTitle < ActiveRecord::Migration[5.1]
  def change
    add_index :tracks, :title
  end
end
