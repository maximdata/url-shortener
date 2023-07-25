require "rails_helper"

RSpec.describe Urls::Encoder, type: :service do
  describe "#call" do
    let(:original_url) { "https://example.com" }
    let(:service) { described_class.new(original_url) }

    context "when url is valid" do
      before do
        allow(SecureRandom).to receive(:alphanumeric).and_return("GeAi9K")
      end

      it "creates a new url" do
        expect { service.call }.to change(Url, :count).by(1)
      end

      it "returns url with the correct original url" do
        url = service.call
        expect(url.original_url).to eq(original_url)
      end

      it "returns url with the correct short url" do
        url = service.call
        expect(url.short_url).to eq("https://short.est/GeAi9K")
      end
    end

    context "when url is not valid" do
      let(:original_url) { "not a valid url" }

      it "does not create a new url" do
        expect { service.call }.not_to(change(Url, :count))
      end
    end
  end
end
