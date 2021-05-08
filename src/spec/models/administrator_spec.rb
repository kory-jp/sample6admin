require 'rails_helper'

RSpec.describe Administrator, type: :model do
  describe "password=" do
    example "文字列を与えると,hashed_passwordは長さ60の文字列になる" do
      user = Administrator.new
      user.password = "sample"
      expect(user.hashed_password).to be_kind_of(String)
      expect(user.hashed_password.size).to eq(60)
    end

    example "nilを与えると,hashed_passwordはnilになる" do
      user = Administrator.new(hashed_password: "x")
      user.password = nil
      expect(user.hashed_password).to be_nil
    end
  end
end
