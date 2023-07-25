require "rails_helper"

RSpec.describe Api::V1::UrlsController do
  let(:original_url) { "https://example.com" }
  let(:short_url) { "https://short.est/GeAi9K" }
  let(:encoder_service) { instance_double(Urls::Encoder) }
  let(:decoder_service) { instance_double(Urls::Decoder) }

  before do
    allow(Urls::Encoder).to receive(:new).and_return(encoder_service)
    allow(Urls::Decoder).to receive(:new).and_return(decoder_service)
  end

  describe "POST #encode" do
    context "with valid url" do
      before do
        allow(encoder_service).to receive(:call).and_return(create(:url, original_url: original_url, short_url: short_url))
      end

      it "returns a success response" do
        post :encode, params: { url: original_url }
        expect(response).to be_successful
      end

      it "returns encoded url" do
        post :encode, params: { url: original_url }
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["url"]).to eq(original_url)
      end

      it "returns short url" do
        post :encode, params: { url: original_url }
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["short_url"]).to eq(short_url)
      end
    end

    context "with invalid url" do
      before do
        allow(encoder_service).to receive(:call).and_return(nil)
      end

      it "returns an error response" do
        post :encode, params: { url: "not_a_url" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "POST #decode" do
    context "with valid short url" do
      before do
        allow(decoder_service).to receive(:call).and_return(build(:url, original_url: original_url, short_url: short_url))
      end

      it "returns a success response" do
        post :decode, params: { short_url: short_url }
        expect(response).to be_successful
      end

      it "returns original url" do
        post :decode, params: { short_url: short_url }
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["url"]).to eq(original_url)
      end

      it "returns short url" do
        post :decode, params: { short_url: short_url }
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["short_url"]).to eq(short_url)
      end
    end

    context "with invalid short url" do
      before do
        allow(decoder_service).to receive(:call).and_return(nil)
      end

      it "returns an error response" do
        post :decode, params: { short_url: "not_a_url" }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
