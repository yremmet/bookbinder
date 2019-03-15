FROM  ductha/bookbinder

RUN   gem install bundle && \
      cd /app && \
      bundle install
      
CMD  bundle exec bookbinder watch
