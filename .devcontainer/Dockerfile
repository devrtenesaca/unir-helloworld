FROM mcr.microsoft.com/devcontainers/python:3.11

# 1. Install Java (WireMock dependency)
RUN apt-get update && apt-get install -y default-jre wget

# 2. Download WireMock Standalone JAR
RUN wget https://repo1.maven.org/maven2/org/wiremock/wiremock-standalone/3.3.1/wiremock-standalone-3.3.1.jar -O /usr/local/bin/wiremock.jar

# 3. Handle Python requirements (your existing logic)
COPY requirements.txt /tmp/pip-tmp/
RUN pip3 --disable-pip-version-check --no-cache-dir install -r /tmp/pip-tmp/requirements.txt \
    && rm -rf /tmp/pip-tmp