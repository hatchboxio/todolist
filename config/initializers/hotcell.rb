# The images cell makes thumbnails from uploads, so the untrusted bytes are
# only ever decoded in a container with no network, no credentials and nothing
# worth stealing. Hatchbox runs the cell beside the app's containers and sets
# HOTCELL_ROOT and HOTCELL_GROUP; without them every cell is off.
module Images
  class UnprocessableImage < StandardError; end
  class ThumbnailUnavailable < StandardError; end
end

HotCell.root = ENV["HOTCELL_ROOT"]
HotCell.group = ENV["HOTCELL_GROUP"]

HotCell.register "images", timeout: 30, permanent: Images::UnprocessableImage, transient: Images::ThumbnailUnavailable

# Warns at boot about a cell that's unreachable, in the wrong group or on another Hot Cell version
Rails.application.config.after_initialize { HotCell.describe_cells }
