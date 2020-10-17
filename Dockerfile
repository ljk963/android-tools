FROM node:12.19

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
RUN apt update \
    && apt install -y openjdk-8-jdk \
    && apt clean

ENV GRADLE_VERSION 6.7
ENV GRADLE_HOME /opt/gradle
RUN wget --no-verbose --output-document=gradle.zip "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" \
    && unzip gradle.zip \
    && rm gradle.zip \
    && mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}/" \
    && ln --symbolic "${GRADLE_HOME}/bin/gradle" /usr/bin/gradle

ENV ANDROID_SDK_ROOT=/opt/android-sdk
RUN wget --no-verbose --output-document=commandlinetools.zip "https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip" \
    && unzip -d "${ANDROID_SDK_ROOT}" commandlinetools.zip \
    && rm commandlinetools.zip \
    && ln --symbolic "${ANDROID_SDK_ROOT}/tools/bin/sdkmanager" /usr/bin/sdkmanager \
    && yes | sdkmanager --sdk_root="${ANDROID_SDK_ROOT}/" --install tools