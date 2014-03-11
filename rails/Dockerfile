FROM ubuntu:13.04
 
MAINTAINER Mel Gray <melgray@gmail.com>

RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ precise-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://us.archive.ubuntu.com/ubuntu/ precise-backports main restricted universe multiverse" >> /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y git build-essential automake autoconf libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl curl wget libpq-dev libpq5 vim zlib1g-dev openssl libssl-dev libxml2 libxml2-dev libxslt1.1 libxslt1-dev libmysqlclient-dev libmysqlclient18 libpq-dev libpq5 libsqlite3-0 libsqlite3-0-dbg libsqlite3-dev jq mercurial bison

RUN git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv
RUN mkdir -p /usr/local/rbenv/plugins

RUN git clone https://github.com/sstephenson/ruby-build /usr/local/rbenv/plugins/ruby-build
RUN git clone https://github.com/sstephenson/rbenv-vars /usr/local/rbenv/plugins/rbenv-vars
RUN git clone https://github.com/jf/rbenv-gemset /usr/local/rbenv/plugins/rbenv-gemset

ADD ./rbenv.sh /etc/profile.d/rbenv.sh
RUN chmod +x /etc/profile.d/rbenv.sh
ENV RBENV_ROOT /usr/local/rbenv
ENV PATH /usr/local/rbenv/shims:/usr/local/rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN rbenv install 2.0.0-p353
RUN rbenv global 2.0.0-p353

RUN mkdir /root/.ssh
RUN chmod 700 /root/.ssh

ADD ./setup.sh /setup.sh 
RUN chmod +x /setup.sh

ADD ./puma.rb /puma.rb

ADD ./run_app.sh /run_app.sh
RUN chmod +x /run_app.sh

VOLUME /app
 
CMD /run_app.sh
