FROM bellsoft/liberica-openjdk-alpine:14.0.1

MAINTAINER Softcom NVPSV Team

RUN echo "build JMetr 5.3 "

# для ручного добавления
#ADD apache-jmeter-5.3 /opt/apache-jmeter-5.3

ENV JMETER_VERSION 5.3
RUN wget https://www2.apache.paket.ua/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz \
    && tar -C /opt -xzvf apache-jmeter-$JMETER_VERSION.tgz \
    && rm apache-jmeter-$JMETER_VERSION.tgz \
    && apk add --no-cache bash

RUN ls /opt/apache-jmeter-5.3

WORKDIR /opt/apache-jmeter-5.3/bin

RUN bash -c 'touch ./jmeter'
RUN bash -c 'touch ./jmeter.sh'
RUN ls

RUN chmod +x jmeter.sh
RUN chmod +x jmeter

