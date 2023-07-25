module Urls
  class Decoder
    attr_reader :short_url

    def initialize(short_url)
      @short_url = short_url
    end

    def call
      Url.find_by(short_url: short_url)
    end
  end
end
