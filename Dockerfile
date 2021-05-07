FROM ruby:3.0.0 
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential nodejs yarn \
  # 下記を今後追加
  && apt-get install -y nodejs mariadb-client
RUN mkdir /sample6admin
WORKDIR /sample6admin
COPY ./src/Gemfile /sample6admin/Gemfile
COPY ./src/Gemfile.lock /sample6admin/Gemfile.lock
RUN bundle install
COPY ./src /sample6admin

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

# docker-compose run web rails new . --force --ni-deps -d mysql
# docker-compose build
# db config
# docker-compose run web rails db:create