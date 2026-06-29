# frozen_string_literal: true

require 'spec_helper'
require './lib/Cache/cache'
require 'fileutils'

RSpec.describe Cache do
  
    before do
        FileUtils.mkdir_p('cache')
        FileUtils.rm_f("cache/#{gem_name}.json")
    end

    after do
        FileUtils.rm_f("cache/#{gem_name}.json")
    end

    let(:cache) { Cache.new }
    let(:gem_name) { 'cucumber' }
    let(:gem_json) do
        File.read('spec/fixtures/gem_json.json')
    end

  describe '#save' do
    it 'creates a cache file' do
      cache.save(gem_name, gem_json)

      expect(File.exist?("cache/#{gem_name}.json")).to be true
    end
  end

  describe '#get' do
    it 'returns nil if cache does not exist' do
      expect(cache.get(gem_name)).to be_nil
    end

    it 'returns cached gems if cache exists' do
      cache.save(gem_name, gem_json)

      expect(cache.get(gem_name)).to eq(gem_json)
    end

    it 'deletes the cache file if it is older than two days' do
        cache.save(gem_name, gem_json)

        old_time = Time.now - (3 * 24 * 60 * 60)
        File.utime(old_time, old_time, "cache/#{gem_name}.json")

        cache.get(gem_name)

        expect(File.exist?("cache/#{gem_name}.json")).to be false
    end
  end
end