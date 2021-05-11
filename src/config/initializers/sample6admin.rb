Rails.application.configure do
  config.sample6admin = {
    customer: { host: "sample6admin.com", path: "" },
    admin: { host: "sample6admin.com", path: "admin"}
  }
end