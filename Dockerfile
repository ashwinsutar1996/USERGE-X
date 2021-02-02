# set base image (host OS)
FROM python:3.9-slim-buster

# set the working directory in the container
WORKDIR /app/

RUN apt -qq update && apt -qq upgrade -y 
RUN apt -qq install -y --no-install-recommends \
    curl \
    git \
    gnupg2 \
    unzip \
    wget \
    ffmpeg \
    jq \
    neofetch \
    apt-utils \
    python3-dev \
    gcc \
    zlib1g-dev \
    mediainfo \
    libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libgif-dev \
    libwebp-dev

# clean up
RUN rm -rf /var/lib/apt/lists/*

# install chrome
RUN mkdir -p /tmp/ && \
    cd /tmp/ && \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    # -f ==> is required to --fix-missing-dependancies
    dpkg -i ./google-chrome-stable_current_amd64.deb; apt -fqqy install && \
    # clean up the container "layer", after we are done
    rm ./google-chrome-stable_current_amd64.deb

# install chromedriver
RUN mkdir -p /tmp/ && \
    cd /tmp/ && \
    wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip  && \
    unzip /tmp/chromedriver.zip chromedriver -d /usr/bin/ && \
    # clean up the container "layer", after we are done
    rm /tmp/chromedriver.zip

ENV GOOGLE_CHROME_DRIVER /usr/bin/chromedriver
ENV GOOGLE_CHROME_BIN /usr/bin/google-chrome-stable

# copy the dependencies file to the working directory
COPY requirements.txt .

# install dependencies
RUN pip install -U pip setuptools wheel && pip install -r requirements.txt

# copy the content of the local src directory to the working directory
COPY . .

# adding email and username to the bot
RUN git config --global user.email "ashwinsutar1996@gmail.com"
RUN git config --global user.name "ashwinsutar1996"

# command to run on container start
CMD [ "bash", "./run" ]
