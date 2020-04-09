# frozen_string_literal: true

##
# Fill up our knowledge of assets packs so it can later be used when rendering
# the main layout.

require 'portus/assets_packs'

PORTUS_ASSETS_PACKS = ::Portus::AssetsPacks.new
PORTUS_ASSETS_PACKS.fill_up_entries!
