require "rails_helper"

describe Customer::Authenticator do
  describe "authenticate" do
    example "正しいパスワードならtrueを返す" do
      m = build(:customer)
      expect(Customer::Authenticator.new(m).authenticate("pw")).to be_truthy
    end

    example "謝ったパスワードならfalseを返す" do
      m = build(:customer)
      expect(Customer::Authenticator.new(m).authenticate("xy")).to be_falsey
    end

    example "パスワード未設定ならfalseを返す" do
      m = build(:customer, password: nil)
      expect(Customer::Authenticator.new(m).authenticate(nil)).to be_falsey
    end

    example "停止フラグが立っていてもtrueを返す" do
      m = build(:customer, suspended: true)
      expect(Customer::Authenticator.new(m).authenticate("pw")).to be_truthy
    end
  end
end