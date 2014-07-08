FROM java

ADD jbilling-community-3.1.0/ /usr/local/jbilling/

WORKDIR /usr/local/jbilling/bin
RUN chmod +x *.sh

CMD ["./catalina.sh", "run"]
