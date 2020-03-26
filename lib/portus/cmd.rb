# frozen_string_literal: true

# :nocov:

require "pty"

module ::Portus
  class Cmd
    # Spawn a new command and return its exit status. It will print to stdout on
    # real time.
    def self.spawn(cmd)
      success = true

      ::PTY.spawn(cmd) do |stdout, _, pid|
        # rubocop:disable Rails/Output
        # rubocop:disable Lint/SuppressedException
        begin
          stdout.each { |line| print line }
        rescue Errno::EIO
          # End of output
        end
        # rubocop:enable Rails/Output
        # rubocop:enable Lint/SuppressedException

        Process.wait(pid)
        success = $CHILD_STATUS.exitstatus.zero?
      end
      success
    end
  end
end
