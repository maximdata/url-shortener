require "rails_helper"

RSpec.describe Url do
  subject(:url) { build(:url) }

  context "when validating" do
    it { is_expected.to validate_presence_of(:original_url) }

    it { is_expected.to validate_presence_of(:short_url) }

    it { is_expected.to validate_uniqueness_of(:short_url) }

    it "validates original url has valid format" do
      expect(url).to allow_value("https://example.com").for(:original_url)
    end

    it "validates original url has invalid format" do
      expect(url).not_to allow_value("invalid_url").for(:original_url)
    end
  end
end
