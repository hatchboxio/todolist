# frozen_string_literal: true

# Loaded in the supervisor at boot, so libvips is already in memory when a
# worker forks for a request; no image is evaluated before the fork.
require "vips"

class ThumbnailOperation < HotCell::Operation
  operation "images.thumbnail"
  limits deadline: 30

  # Each worker handles one request, on one thread, inside the container's cpu quota
  before_worker_boot { Vips.concurrency_set 1 }

  # A file libvips can't decode is the caller's problem, not the cell's
  unreadable Vips::Error

  def perform(inputs, outputs, width: 200)
    source, = inputs
    destination, = outputs

    # Read in place through the descriptor, nothing is copied onto scratch
    image = Vips::Image.thumbnail(source.fd_path, Integer(width))
    png = image.write_to_buffer(".png")
    File.binwrite(destination.fd_path, png)

    { width: image.width, height: image.height, bytes: png.bytesize }
  end
end
