module Urls
  class Encoder
    attr_reader :original_url

    def initialize(original_url)
      @original_url = original_url
    end

    def call
      Url.create(
        original_url: original_url,
        short_url: generate_short_url
      )
    end

    private

    def generate_short_url
      "https://short.est/#{random_string}"
    end

    def random_string
      SecureRandom.alphanumeric(6)
    end
  end
end
