FROM java

RUN apt-get update && apt-get install -y curl unzip

ENV JBILLING_VERSION 3.1.0

RUN curl -SL "http://downloads.sourceforge.net/project/jbilling/jbilling%20Latest%20Stable/jbilling-${JBILLING_VERSION}/jbilling-community-${JBILLING_VERSION}.zip" -o /jbilling.zip \
	&& unzip /jbilling.zip -d /usr/local \
	&& rm /jbilling.zip \
	&& ln -s "jbilling-community-${JBILLING_VERSION}" /usr/local/jbilling
WORKDIR /usr/local/jbilling
RUN chmod +x bin/*.sh

ADD docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8080
CMD ["bin/catalina.sh", "run"]
