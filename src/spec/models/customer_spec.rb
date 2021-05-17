require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "password" do
    example "文字列を与えると,hashed_passwordは長さ60の文字列になる" do
      user = Customer.new
      user.password = "sample"
      expect(user.hashed_password).to be_kind_of(String)
      expect(user.hashed_password.size).to eq(60)
    end

    example "nilを与えると、hashed_passwordはnilになる" do
      user = Customer.new(hashed_password: "x")
      user.password = nil
      expect(user.hashed_password).to be_nil
    end
  end

  describe "値を正規化" do
    example "email前後の空白を除去" do
      member = create(:customer, email: " test@example.com")
      expect(member.email).to eq("test@example.com")
    end

    example "emailに含まれる全角英数字記号を半角に変換" do
      member = create(:customer, email: "ｔｅｓｔ＠ｅｘａｍｐｌｅ．ｃｏｍ")
      expect(member.email).to eq("test@example.com")
    end

    example "email前後の全角スペースを除去" do
      member = create(:customer, email: "\u{3000}test@example.com\u{3000}")
      expect(member.email).to eq("test@example.com")
    end
  end

  describe "バリデーション" do
    example "@を2個含むemailは無効" do
      member = build(:customer, email: "test@@example.com")
      expect(member).not_to be_valid
    end

    example "アルファベット表記のnameは有効" do
      member = build(:customer, name: "john")
      expect(member).to be_valid
    end

    example "記号を含むnameは無効" do
      member = build(:customer, name:"テスト★")
      expect(member).not_to be_valid
    end

    example "他の職員のメールアドレスと重複したemailは無効" do
      member1 = create(:customer)
      member2 = build(:customer, email: member1.email)
      expect(member2).not_to be_valid
    end
  end
end
