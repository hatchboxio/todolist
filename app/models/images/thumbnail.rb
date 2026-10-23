# Asks the images cell for a PNG thumbnail of an image. The app hands over an
# open read-only file and an open write-only one; the cell decodes the image.
class Images::Thumbnail < HotCell::Client
  hotcell "images"
  operation "images.thumbnail"
end
