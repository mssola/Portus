# frozen_string_literal: true

module Portus
  # AssetsPacks deals with the current javascript packs used by this
  # application.
  class AssetsPacks
    # The path where our packs are located.
    PACKS_LOCATION = 'app/frontend/packs'

    # Packs that should never be considered. We are only dealing with packs that
    # fall inside of the 'application' view layout.
    RESERVED_PACKS = ['unauthenticated.js', 'errors.js'].freeze

    # Pack to be used whenever there is no pack for the given controller.
    DEFAULT_PACK = 'main'

    def initialize
      @entries = []
    end

    # Properly initialize the entries from this application by looking inside of
    # PACKS_LOCATION. Packs referenced by the RESERVED_PACKS array will be
    # ignored, as well as hidden files (including '.' and '..').
    def fill_up_entries!
      Rails.root.join(PACKS_LOCATION).entries.each do |entry|
        str = entry.to_s

        next if str.start_with?('.')
        next if RESERVED_PACKS.include?(str)

        @entries.push(str.delete_suffix(entry.extname))
      end

      Rails.logger.tagged(:assets_packs) { Rails.logger.debug "Loaded entries: #{@entries}" }
    end

    # Returns the pack name for the given entry (controller). If it could not be
    # found, then the DEFAULT_PACK is returned.
    def pack_for(name)
      return name if @entries.include?(name)

      DEFAULT_PACK
    end
  end
end
