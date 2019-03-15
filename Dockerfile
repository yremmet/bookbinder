FROM ubuntu:14.04 

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Install any needed packages 
RUN apt-get update && apt-get install -y \
	git-core \
	curl \
	zlib1g-dev \
	build-essential \
	libssl-dev \
	libreadline-dev \
	libyaml-dev \
	libsqlite3-dev sqlite3 \
	libxml2-dev libxslt1-dev \
	libcurl4-openssl-dev \
	python-software-properties \
	libffi-dev \
	wget && rm -rf /var/lib/apt/lists/*
# Install ruby 2.3.1 and bookbinder
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv; \
	echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc; \
	echo 'eval "$(rbenv init -)"' >> ~/.bashrc; \
	exec $SHELL; \
	git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build; \
	echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc;  \
	exec $SHELL; \
	export PATH="$HOME/.rbenv/bin/:$HOME/.rbenv/plugins/ruby-build/bin:$HOME/.rbenv/versions/2.3.1/bin:$PATH";\
	rbenv install 2.3.1; \
	rbenv global 2.3.1; \
	gem install bundle; \
	gem install 'bookbindery' \
    cd /app \
    bundle install \

# Make port 4567 available to the world outside this container. Still need to publish this port with -p when running the container.
EXPOSE 4567/tcp


# By default, launch a bash shell.
ENTRYPOINT /bin/bash 

CMD bundle exec bookbinder watch