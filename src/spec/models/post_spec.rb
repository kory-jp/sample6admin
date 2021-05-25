require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "顧客にとる投稿管理" do
    let(:customer) {create(:customer)}
    let(:post) {create(:post, customer_id: customer.id)}
    example "成功" do
      expect(post).to be_valid
    end

    example "タイトルがない場合は無効である" do
      post.title = nil
      expect(post).not_to be_valid
    end

    example "タイトルが31文字以上の場合は無効である" do
      post.title = "a" * 31
      expect(post).not_to be_valid
    end

    example "本文がない場合は無効である" do
      post.body = nil
      expect(post).not_to be_valid
    end

    example "本文が1001文字以上の場合は無効である" do
      post.title = "a" * 1001
      expect(post).not_to be_valid
    end
  end
end
