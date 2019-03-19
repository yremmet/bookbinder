FROM  ductha/bookbinder:10.1.14

COPY Gemfile Gemfile

RUN /root/.rbenv/shims/gem install bundle && \
    /root/.rbenv/versions/2.3.1/bin/bundle install

ENTRYPOINT .  ~/.bashrc; \
           cd /app/docs-book; \
           bundle install; ls; \
           bundle exec bookbinder watch

CMD cd /app/docs-book; bundle exec bookbinder watch
