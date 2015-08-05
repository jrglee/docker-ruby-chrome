FROM ubuntu:trusty

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install software-properties-common wget git curl xvfb unzip

# deps for ruby
RUN apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

# ruby ppa
RUN add-apt-repository -y ppa:brightbox/ruby-ng

# chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

RUN apt-get update

RUN apt-get -y install ruby2.1 ruby2.1-dev google-chrome-stable

# Dependencies to make "headless" chrome/selenium work:
RUN apt-get -y install xvfb gtk2-engines-pixbuf
RUN apt-get -y install xfonts-cyrillic xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable

# chrome driver
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/2.16/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/bin/
RUN chmod ugo+rx /usr/bin/chromedriver

RUN gem install bundler nokogiri

ADD docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
