require 'net/http'
require 'uri'
require 'rexml/document'

class SearchConditionsController < ApplicationController
  def index
    # uriの細分化
    uri_host = "https://webservice.recruit.co.jp/"
    uri_path = "hotpepper/gourmet/v1/"
    uri_query = "?key=#{ENV['GOURMET_API_KEY']}&large_area=Z011&count=1"

    parsed_uri = URI.parse(uri_host + uri_path + uri_query)
    # Net::HTTP.newでHTTPのクライアントのオブジェクトを作成
    http = Net::HTTP.new(parsed_uri.host, parsed_uri.port)
    #HTTP で SSL/TLS を使うかどうかを設定する。HTTPSを使う場合はtureを設定する。でデフォルトはfalse
    http.use_ssl = true

    # Net::HTTP::Get.newでGETリクエストのオブジェクトを作成
    request = Net::HTTP::Get.new(parsed_uri.request_uri)

    # HTTPクライアントを利用してGETのリクエスト
    response = http.request(request)
    
    doc = REXML::Document.new(response.body)
    
    @shops = []

    shops = REXML::XPath.match(doc, "/results/shop").map do |shop|
      @shops.push(shop.elements["name"].text)
    end
    
    coordinates = []
    if params[:coordinates].present?
      coordinates = params[:coordinates].split(",")
      coordinates = coordinates.map(&:to_f)

      p coordinates

      @latitude = coordinates[0]
      @longitude = coordinates[1]
    end
  end
end