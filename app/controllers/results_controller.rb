require 'net/http'
require 'uri'
require 'rexml/document'

class ResultsController < ApplicationController
  def index
    @restaurants = []
    @radius = case params[:rad] 
              when "1" then "300m"
              when "2" then "500m" 
              when "3" then "1.0km"
              when "4" then "2.0km"
              when "5" then "3.0km"
              else "Error"
              end

    # 環境変数が設定されていない場合はエラーを出す
    unless ENV['GOURMET_API_KEY'] then
      raise "GOURMET_API_KEY is not set"
    end

    # パラメータがない場合はトップページにリダイレクト
    unless params[:lat] && params[:lng] && params[:rad] then
      redirect_to root_path
    end

    # uriの細分化
    uri_host = "https://webservice.recruit.co.jp/"
    uri_path = "hotpepper/gourmet/v1/"
    uri_query = "?key=#{ENV['GOURMET_API_KEY']}&lat=#{params[:lat]}&lng=#{params[:lng]}&range=#{params[:rad]}&count=100"
    parsed_uri = URI.parse(uri_host + uri_path + uri_query)

    # Net::HTTP.newでHTTPのクライアントのオブジェクトを作成
    http = Net::HTTP.new(parsed_uri.host, parsed_uri.port)
    #HTTPでSSL/TLSを使うかどうかを設定する。
    http.use_ssl = true
    request = Net::HTTP::Get.new(parsed_uri.request_uri)
    response = http.request(request)
    
    doc = REXML::Document.new(response.body)
    
    @restaurants = Array.new()

    REXML::XPath.match(doc, "/results/shop").map do |restaurant|
      restaurant_temp = Hash.new()
      restaurant_temp.store(:id, restaurant.elements["id"].text)
      restaurant_temp.store(:thumbnail_url, restaurant.elements["logo_image"].text)
      restaurant_temp.store(:name, restaurant.elements["name"].text)
      restaurant_temp.store(:address, restaurant.elements["address"].text)
      restaurant_temp.store(:access, restaurant.elements["access"].text)

      @restaurants << restaurant_temp
    end

    p @restaurants
    @paginatable_restaurants = Kaminari.paginate_array(@restaurants).page(params[:page]).per(10)
  end
end
