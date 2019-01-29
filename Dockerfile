FROM gradle
USER root
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
RUN mkdir -p /root/.android
RUN touch /root/.android/repositories.cfg
RUN sdkmanager "platform-tools" "platforms;android-28" "build-tools;28.0.3"
RUN sdkmanager --update

USER gradle
RUN gradle