module ApplicationHelper
  def gourmet_api_request(_parsed_uri) {
    # Net::HTTP.newでHTTPのクライアントのオブジェクトを作成
    # Net::HTTP.newでHTTPのクライアントのオブジェクトを作成
    http = Net::HTTP.new(parsed_uri.host, parsed_uri.port)
    #HTTPでSSL/TLSを使うかどうかを設定する。
    http.use_ssl = true
    request = Net::HTTP::Get.new(parsed_uri.request_uri)

    return http.request(request)
  }
end
