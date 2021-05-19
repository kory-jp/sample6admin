Customer.create!(
  email: "sample@example.com",
  name: "山田太郎",
  nickname: "yamada",
  password: "password",
  introduction: "こんにちは"
)

family_names = %w{
  佐藤:sato
  鈴木:suzuki
  高橋:takahashi
  田中:tanaka
}

given_names = %w{
  二郎:jiro
  三郎:saburo
  松子:matsuko
  竹子:takeko
  梅子:umeko
}

20.times do |n|
  fn = family_names[n % 4].split(":")
  gn = given_names[n % 5].split(":")

  Customer.create!(
    email: "#{fn[1]}.#{gn[1]}@example.com",
    name: "#{fn[0]}#{gn[0]}",
    password: "password",
    suspended: n == 1,
    introduction: "はじめまして！#{fn[0]} #{gn[0]}です!"
  )
end
