class CreateSongs < ActiveRecord::Migration[4.2]
  belongs_to :artist
  belongs_to :genre
end
