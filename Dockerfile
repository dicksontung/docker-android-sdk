FROM debian
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk wget unzip && \
    rm -rf /var/lib/apt/lists/*

ENV ANDROID_HOME /opt/android-sdk-linux

RUN mkdir -p ${ANDROID_HOME} && \
    cd ${ANDROID_HOME} && \
    wget -q https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -O android_tools.zip && \
    unzip android_tools.zip && \
    rm android_tools.zip

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

RUN yes | sdkmanager --licenses