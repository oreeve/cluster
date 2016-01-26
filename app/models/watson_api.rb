require 'json'
require 'faraday'
require 'open-uri'

class WatsonApi
  attr_reader :data

  def initialize(doc)
    if Rails.env.production?
      @doc = doc.url
    else
      @doc = doc.path
    end

    @data = get_doc
  end

  def questions
    @data.values[3].map { |item| [item["title"], item["content"][0]["text"]] }
  end

  private

  def get_doc
    base_url = "https://gateway.watsonplatform.net"
    version = "2015-12-15"
    path = "/document-conversion/api/v1/convert_document?version=#{version}"
    basic_auth_username = ENV["WATSON_USERNAME"]
    basic_auth_password = ENV["WATSON_PASSWORD"]

    conn = Faraday.new(url: base_url) do |faraday|
      faraday.request :multipart
      faraday.request :url_encoded
      faraday.adapter :net_http
    end

    conn.basic_auth(basic_auth_username, basic_auth_password)

    payload = {}
    if Rails.env.production?
      payload = {
        config: Faraday::UploadIO.new(
          "#{::Rails.root}/lib/WatsonApi/config.json", "application/json"),
        file: Faraday::UploadIO.new(open(@doc), "application/pdf")
      }
    else
      payload = {
        config: Faraday::UploadIO.new(
          "#{::Rails.root}/lib/WatsonApi/config.json", "application/json"),
        file: Faraday::UploadIO.new(@doc, "application/pdf")
      }
    end
    response = conn.post(path, payload)
    json_response_body = JSON.parse(response.body)
  end
end
