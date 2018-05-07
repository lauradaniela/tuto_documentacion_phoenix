FROM elixir:1.6.4
ENV DEBIAN_FRONTEND=noninteractive

# Install hex
RUN mix local.hex --force

# Install rebar
RUN mix local.rebar --force

# Install the Phoenix framework itself
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phx_new.ez
RUN mix archive.install http://git.io/edib-0.9.0.ez

# Install NodeJS 6.x and the NPM
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get install -y -q nodejs

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update
RUN apt-get install -y postgresql-client-9.6

RUN apt-get install -y inotify-tools

# Set /app as workdir
RUN mkdir /app
ADD . /app
WORKDIR /app
