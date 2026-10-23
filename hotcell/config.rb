# frozen_string_literal: true

# Loaded when the cell boots, before any operation.
#
# deadline and queue_wait are seconds; memory and file_size are bytes. memory is
# RLIMIT_DATA for one worker (address space, 1024MB is the floor), not the
# container's cgroup limit, which Hatchbox sets from HATCHBOX_HOTCELL_MEMORY.
HotCell.limits concurrency: 2, queue_size: 4, deadline: 30, memory: 1024 * 1024**2, file_size: 32 * 1024**2
