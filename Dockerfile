FROM ubuntu:18.04

# Prerequisites
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-11-jdk wget

# Set up new user
# RUN useradd -ms /bin/bash developer
# USER developer
WORKDIR /home/developer

# Prepare Android directories and system variables
RUN mkdir -p Android/sdk/cmdline-tools
ENV ANDROID_HOME /home/developer/Android/sdk
RUN mkdir -p .android && touch .android/repositories.cfg

# Set up Android SDK
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-9123335_latest.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv cmdline-tools Android/sdk/cmdline-tools/tools
RUN cd Android/sdk/cmdline-tools/tools/bin && yes | ./sdkmanager --licenses
RUN cd Android/sdk/cmdline-tools/tools/bin && ./sdkmanager "build-tools;33.0.0" "patcher;v4" "platform-tools" "platforms;android-33" "sources;android-33"
ENV PATH "$PATH:/home/developer/Android/sdk/cmdline-tools"

# Download Flutter SDK
RUN git clone https://github.com/flutter/flutter.git -b 3.7.0
ENV PATH "$PATH:/home/developer/flutter/bin"

# Run basic check to download Dark SDK
RUN flutter doctor
#RUN flutter upgrade

# Copy files to container and build
RUN mkdir /home/developer/app
COPY . /home/developer/app
WORKDIR /home/developer/app

# RUN flutter pub upgrade --major-versions
RUN flutter gen-l10n
# WORKDIR /app/

# EXPOSE 5000
RUN chmod +x deploy.sh

CMD ["tail", "-f", "/dev/null"]
