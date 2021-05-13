require "rails_helper"

describe "管理者による職員管理" do
  let(:administrator){create(:admin_customer)}

  describe "新規登録" do
    let(:params_hash){attributes_for(:customer)}

    example "職員一覧ページにリダイレクト" do
      post admin_customers_url, params: {customer: params_hash}
      expect(response).to redirect_to(admin_customers_url)
    end

    example "メールアドレスが空白の場合は登録失敗" do
      params_hash.merge!(email: "" )
      post admin_customers_url, params: {customer: params_hash}
      expect(response).not_to have_http_status "200"
    end

    example "例外ActionController::ParameterMissingが発生" do
      expect {post admin_customers_url}.to raise_error(ActionController::ParameterMissing)
    end
  end

  describe "更新" do
    let(:customer){create(:customer)}
    let(:params_hash){attributes_for(:customer)}

    example "suspendedフラグをセットする" do
      params_hash.merge!(suspended: true)
      patch admin_customer_url(customer),
        params: {customer: params_hash}
      customer.reload
      expect(customer).to be_suspended
    end

    example "hash_passwordの値は書き換え不可" do
      params_hash.delete(:password)
      params_hash.merge!(hashed_password: "x")
      expect{
        patch admin_customer_url(customer),
          params: {customer: params_hash}
      }.not_to change{customer.hashed_password.to_s}
    end
  end
end