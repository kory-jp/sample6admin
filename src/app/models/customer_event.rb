class CustomerEvent < ApplicationRecord
  self.inheritance_column = nil

  belongs_to :member, class_name: "Customer", foreign_key: "customer_id"
  alias_attribute :occurred_at, :created_at

  DESCRIPTIONS = {
    logged_in: "ログイン",
    logged_out: "ログアウト",
    rejected: "ログイン拒否"
  }

  def description 
    DESCRIPTIONS[type.to_sym]
  end
end
