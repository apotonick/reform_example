module Forms
  class AlbumForm < Reform::Form # FIXME: sub forms don't inherit FBM.

    model :album

    property :title

    collection :songs, populate_if_empty: lambda { |*| Song.new } do
      property :name
      validates :name, presence: true

      property :user, populate_if_empty: lambda { |*| Song.new } do
        property :first_name
        property :last_name
      end
    end

    # this validation only gets triggered when params doesn't contain any songs attributes at all.
    validates :songs, :length => {minimum: 1} # yeah, album without any songs doesn't make sense.

    validates :title, presence: true
  end
end
