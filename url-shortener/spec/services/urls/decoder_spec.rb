require "rails_helper"

RSpec.describe Urls::Decoder, type: :service do
  describe "#call" do
    subject(:decoded_url) { described_class.new(short_url).call }

    let(:short_url) { "https://short.est/GeAi9K" }
    let(:url) { create(:url, short_url: short_url) }

    context "when the short url exists" do
      before do
        url
      end

      it "returns the url" do
        expect(decoded_url).to eq(url)
      end
    end

    context "when the short url does not exist" do
      let(:short_url) { "https://short.est/NonExistent" }

      it "returns nil" do
        expect(decoded_url).to be_nil
      end
    end
  end
end
