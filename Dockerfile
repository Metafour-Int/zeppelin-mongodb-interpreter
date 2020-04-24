FROM apache/zeppelin:0.8.2
MAINTAINER Metafour Asia Ltd <mahabobur.rahman@metafour.cm>

ENV LOG_TAG="[ZEPPELIN_${Z_VERSION}]:" \
    Z_HOME="/zeppelin" \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8\
    MONGO_VERSION=3.4
    

RUN echo "$LOG_TAG update and install mongo interpreter" && \
    mkdir $Z_HOME/interpreter/mongodb

COPY target/zeppelin-mongodb-0.7.0-jar-with-dependencies.jar $Z_HOME/interpreter/mongodb	
RUN chmod +r $Z_HOME/interpreter/mongodb/*.*

# Install Mongo Shell
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 && \
    echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/${MONGO_VERSION} main" > /etc/apt/sources.list.d/mongodb-org.list && \
    apt-get update && \
    apt-get install -y mongodb-org-shell
    
EXPOSE 8080

VOLUME ${Z_HOME}/logs ${Z_HOME}/notebook

CMD ["/zeppelin/bin/zeppelin.sh"]
