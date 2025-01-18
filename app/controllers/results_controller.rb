class ResultsController < ApplicationController
  def index
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
    
    @shops = []

    REXML::XPath.match(doc, "/results/shop").map do |shop|
      @shops.push(shop.elements["name"].text)
    end
  end
end
