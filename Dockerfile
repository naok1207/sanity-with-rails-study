FROM ruby:3.0.1

RUN curl -SL https://deb.nodesource.com/setup_14.x | bash - \
 && apt-get install gcc g++ make \
 && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg >/dev/null \
 && echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get update -qq \
 && apt-get install -y nodejs yarn

WORKDIR /app
COPY . /app
RUN bundle config --local set path 'vendor/bundle' \
 && bundle install

COPY start.sh /start.sh
RUN chmod 744 /start.sh
CMD ["sh", "/start.sh"]
