# frozen_string_literal: true

require './lib/commands/show_command'

RSpec.describe ShowCommand do
  describe '#execute' do
    let(:client) { double('APIClient') }
    let(:command) { ShowCommand.new(client) }
    let(:exit_description) do
      "Gem name: rails\nGem info: Ruby on Rails is a full-stack web framework optimized for programmer happiness and sustainable productivity. It encourages beautiful code by favoring convention over configuration."
    end
    let(:gem_json) do
      '{
            "name": "rails",
            "downloads": 756415561,
            "version": "8.1.3",
            "version_created_at": "2026-03-24T20:27:42.098Z",
            "version_downloads": 7351214,
            "platform": "ruby",
            "authors": "David Heinemeier Hansson",
            "info": "Ruby on Rails is a full-stack web framework optimized for programmer happiness and sustainable productivity. It encourages beautiful code by favoring convention over configuration.",
            "licenses": [
                "MIT"
            ],
            "metadata": {
                "changelog_uri": "https://github.com/rails/rails/releases/tag/v8.1.3",
                "bug_tracker_uri": "https://github.com/rails/rails/issues",
                "source_code_uri": "https://github.com/rails/rails/tree/v8.1.3",
                "mailing_list_uri": "https://discuss.rubyonrails.org/c/rubyonrails-talk",
                "documentation_uri": "https://api.rubyonrails.org/v8.1.3/",
                "rubygems_mfa_required": "true"
            },
            "yanked": false,
            "sha": "6d017ba5348c98fc909753a8169b21d44de14d2a0b92d140d1a966834c3c9cd3",
            "spec_sha": "3a316a58ddb9d1ca3ffa17f10af837ba7e0f6e7cc6e413fc4810e89759f149af",
            "project_uri": "https://rubygems.org/gems/rails",
            "gem_uri": "https://rubygems.org/gems/rails-8.1.3.gem",
            "homepage_uri": "https://rubyonrails.org",
            "wiki_uri": null,
            "documentation_uri": "https://api.rubyonrails.org/v8.1.3/",
            "mailing_list_uri": "https://discuss.rubyonrails.org/c/rubyonrails-talk",
            "source_code_uri": "https://github.com/rails/rails/tree/v8.1.3",
            "bug_tracker_uri": "https://github.com/rails/rails/issues",
            "changelog_uri": "https://github.com/rails/rails/releases/tag/v8.1.3",
            "funding_uri": null,
            "dependencies": {
                    "development": [],
                    "runtime": [
                    { "name": "actioncable", "requirements": "= 8.1.3" },
                    { "name": "actionmailbox", "requirements": "= 8.1.3" },
                    { "name": "actionmailer", "requirements": "= 8.1.3" },
                    { "name": "actionpack", "requirements": "= 8.1.3" },
                    { "name": "actiontext", "requirements": "= 8.1.3" },
                    { "name": "actionview", "requirements": "= 8.1.3" },
                    { "name": "activejob", "requirements": "= 8.1.3" },
                    { "name": "activemodel", "requirements": "= 8.1.3" },
                    { "name": "activerecord", "requirements": "= 8.1.3" },
                    { "name": "activestorage", "requirements": "= 8.1.3" },
                    { "name": "activesupport", "requirements": "= 8.1.3" },
                    { "name": "bundler", "requirements": "\u003E= 1.15.0" },
                    { "name": "railties", "requirements": "= 8.1.3" }
                    ]
            }
            }'
    end

    it 'returns exit code 3 when no gem name is given' do
      result = command.execute(nil)

      expect(result.exit_code).to eq(3)
      expect(result.exit_description).to eq('No gem name given')
    end

    it 'returns gem not found for a gem that does not exist' do
      allow(client)
        .to receive(:show)
        .with('bogdana')
        .and_return('Gem not found')

      result = command.execute('bogdana')

      expect(result.exit_code).to eq(4)
      expect(result.exit_description).to eq('Gem not found')
    end

    it 'returns information for rails' do
      allow(client).to receive(:show).with('rails').and_return(JSON.parse(gem_json))

      result = command.execute('rails')

      expect(result.exit_code).to eq(0)
      expect(result.exit_description).to eq(exit_description)
    end
  end
end
