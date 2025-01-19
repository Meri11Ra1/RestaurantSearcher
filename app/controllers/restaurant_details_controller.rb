require 'rexml/document'

class RestaurantDetailsController < ApplicationController
  def index
    @restaurant = Hash.new() # レストラン詳細情報を格納するハッシュ

    # uriの細分化、リクエストの送信
    uri_path = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/"
    uri_query = "?key=#{ENV['GOURMET_API_KEY']}&id=#{params[:id]}"
    parsed_uri = URI.parse(uri_path + uri_query)
    response = gourmet_api_request(parsed_uri)

    # XMLの解析、レストラン情報の格納
    doc = REXML::Document.new(response.body)
    REXML::XPath.match(doc, "/results/shop").map do |restaurant|
      @restaurant.store(:thumbnail_url, restaurant.elements["logo_image"].text)
      @restaurant.store(:name, restaurant.elements["name"].text)
      @restaurant.store(:address, restaurant.elements["address"].text)
      @restaurant.store(:open, restaurant.elements["open"].text)
    end

    p @restaurant
  end
end
