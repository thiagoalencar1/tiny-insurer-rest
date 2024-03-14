FROM ruby:3.3.0
ARG USER_ID
WORKDIR /app
COPY Gemfile ./
COPY Gemfile.lock ./
RUN bundle install
COPY . .
RUN chmod +x ./docker-entrypoint.sh
RUN useradd thiago --uid ${USER_ID} --create-home --shell /bin/bash && \
    chown -R thiago:thiago .
USER thiago:thiago
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["rails", "s", "-b", "0.0.0.0", "-p", "3001"]
