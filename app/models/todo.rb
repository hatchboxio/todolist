class Todo < ApplicationRecord
  THUMBNAIL_WIDTH = 200

  has_one_attached :image
  has_one_attached :thumbnail

  # The thumbnail comes from the images cell, so libvips never runs in this
  # container. Returns what the cell reported about the result.
  def make_thumbnail(width: THUMBNAIL_WIDTH)
    image.open do |download|
      Tempfile.create([ "thumbnail", ".png" ]) do |staging|
        result = File.open(download.path, "rb") do |source|
          File.open(staging.path, "wb") { |destination| Images::Thumbnail.perform_in_hotcell(source, destination, width: width) }
        end
        thumbnail.attach(io: File.open(staging.path, "rb"), filename: "thumbnail.png", content_type: "image/png")
        result
      end
    end
  end
end
