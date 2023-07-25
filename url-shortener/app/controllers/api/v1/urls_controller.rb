class Api::V1::UrlsController < ApplicationController
  def encode
    url = Urls::Encoder.new(url_params[:url]).call
    return render json: { url: url.original_url, short_url: url.short_url }, status: :ok if url&.persisted?

    handle_invalid_url(url)
  rescue StandardError => e
    handle_unknown_error(e)
  end

  def decode
    url = Urls::Decoder.new(url_params[:short_url]).call
    return render json: { url: url.original_url, short_url: url.short_url }, status: :ok if url

    render json: { error: "Short URL not found" }, status: :not_found
  rescue StandardError => e
    handle_unknown_error(e)
  end

  private

  def url_params
    params.permit(:url, :short_url)
  end

  def handle_invalid_url(url)
    if url
      render json: { errors: url.errors.full_messages }, status: :unprocessable_entity
    else
      render json: { error: "URL encoding failed" }, status: :unprocessable_entity
    end
  end

  def handle_unknown_error(exception)
    render json: { error: "Unknown error: #{exception.message}" }, status: :internal_server_error
  end
end
