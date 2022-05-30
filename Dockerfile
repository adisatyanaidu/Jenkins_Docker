FROM python:3.6-slim

MAINTAINER paspnaidu@aol.com

COPY . /python-test-calculator

WORKDIR /python-test-calculator

RUN pip install --no-cache-dir -r requirements.txt

#RUN ["pytest", "-v", "--junitxml=reports/result.xml"]

#CMD tail -f /dev/null

FROM node:16-alpine
LABEL maintainer="Postman Labs <help@postman.com>"

ARG NEWMAN_VERSION

# Set environment variables
ENV LC_ALL="en_US.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8" ALPINE_NODE_REPO="oznu/alpine-node"

# Bail out early if NODE_VERSION is not provided
RUN if [ ! $(echo $NEWMAN_VERSION | grep -oE "^[0-9]+\.[0-9]+\.[0-9]+$") ]; then \
        echo "\033[0;31mA valid semver Newman version is required in the NEWMAN_VERSION build-arg\033[0m"; \
        exit 1; \
    fi && \
    # Install Newman globally
    npm install --global newman@${NEWMAN_VERSION};

# Set workdir to /etc/newman
# When running the image, mount the directory containing your collection to this location
#
# docker run -v <path to collections directory>:/etc/newman ...
# https://github.com/postmanlabs/newman/blob/develop/docker/images/alpine/Dockerfile

WORKDIR /etc/newman


#
# docker run -v /home/collections:/etc/newman -t postman/newman_alpine run YourCollection.json.postman_collection \
#                                                                        -e YourEnvironment.postman_environment \
#                                                                        -H newman_report.html
ENTRYPOINT ["newman"]
