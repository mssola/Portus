# frozen_string_literal: true

require 'rails_helper'

module Portus
  class AssetsPacksMock < AssetsPacks
    attr_reader :entries

    def reserved_packs
      RESERVED_PACKS
    end

    def default_pack
      DEFAULT_PACK
    end
  end
end

describe ::Portus::AssetsPacksMock do
  before :each do
    subject.fill_up_entries!
  end

  it 'does not fill up the entries with reserved stuff' do
    found = 0

    subject.entries.each do |entry|
      found += 1 if subject.reserved_packs.include?("#{entry}.js")
    end

    expect(found.zero?).to be_truthy
  end

  it 'does not fill up the entries with hidden stuff' do
    found = 0

    subject.entries.each { |entry| found += 1 if entry.start_with?('.') }

    expect(found.zero?).to be_truthy
  end

  it 'returns valid packs for found controllers' do
    expect(subject.pack_for('namespaces')).to eq 'namespaces'
  end

  it 'returns the main pack for unknown controllers' do
    expect(subject.pack_for('wubalubadubdub')).to eq subject.default_pack
  end
end
