class CreateArtists < ActiveRecord::Migration[4.2]
    has_many :songs
    has_many :artists, through: :songs
end
