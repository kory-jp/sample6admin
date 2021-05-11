require "rails_helper"

describe "ルーティング" do
  example "職員トップページ" do
    config = Rails.application.config.sample6admin
    url = "http://#{config[:customer][:host]}/#{config[:customer][:path]}"
    expect(get: url).to route_to(
      host: config[:customer][:host],
      controller: "customer/top",
      action: "index"
    )
  end

  example "管理者ログインフォーム" do
    config = Rails.application.config.sample6admin
    url = "http://#{config[:admin][:host]}/#{config[:admin][:path]}"
    expect(get: url).to route_to(
      host: config[:admin][:host],
      controller: "admin/top",
      action: "index"
    )
  end

  example "ホスト名が対象外ならroutableではない" do
    expect(get: "http//foo.example.jp").not_to be_routable
  end

  example "存在しないパスならroutableではない" do
    config = Rails.application.config.sample6admin
    expect(get: "http://#{config[:customer][:host]}/xyz").not_to be_routable
  end
end