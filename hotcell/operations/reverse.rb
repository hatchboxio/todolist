# frozen_string_literal: true

# Reverses a string inside the cell, and reports what the cell can see of
# itself, so a deploy can be checked end to end from the app's /hotcell page
require "socket"

class ReverseOperation < HotCell::Operation
  operation "todolist.reverse"

  def perform(_inputs, _outputs, text:)
    network = Socket.getifaddrs.map(&:name).uniq - [ "lo" ]

    { reversed: text.reverse, uid: Process.uid, gid: Process.gid, interfaces: network }
  end
end
