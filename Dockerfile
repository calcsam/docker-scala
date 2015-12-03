# Scala on Java 7
#
# URL: https://github.com/William-Yeh/docker-scala
#
# forked from: pulse00/scala
#              - https://index.docker.io/u/pulse00/scala/
#              - https://github.com/dubture-dockerfiles/scala
#
# Version     0.7

FROM williamyeh/java7
MAINTAINER William Yeh <william.pjyeh@gmail.com>


ENV SCALA_VERSION 2.11.6
ENV SCALA_TARBALL http://www.scala-lang.org/files/archive/scala-$SCALA_VERSION.deb


RUN \
    echo "==> Install curl helper tool..."  && \
    apt-get update  && \
    DEBIAN_FRONTEND=noninteractive  apt-get install -y --force-yes curl  && \
    \
    \
    \
    echo "===> install from Typesafe repo (contains old versions but they have all dependencies we need later on)"  && \
    curl -sSL http://apt.typesafe.com/repo-deb-build-0002.deb  -o repo-deb.deb  && \
    dpkg -i repo-deb.deb  && \
    apt-get update        && \
    \
    \
    \
    echo "===> install Scala"  && \
    DEBIAN_FRONTEND=noninteractive \
        apt-get install -y --force-yes libjansi-java  && \
    curl -sSL $SCALA_TARBALL -o scala.deb             && \
    dpkg -i scala.deb                                 && \
    \
    \
    \
    echo "===> clean up..."  && \
    rm -f *.deb                            && \
    apt-get clean                          && \
    rm -rf /var/lib/apt/lists/*


# print versions
#RUN java -version

# scala -version returns code 1 instead of 0 thus "|| true"
#RUN scala -version || true

# Define default command.
#CMD ["scala"]

#RUN apt-get install yum
#RUN yum update -y && yum install -y unzip
RUN apt-get install -y --force-yes curl
RUN apt-get update  && \
    DEBIAN_FRONTEND=noninteractive  apt-get install -y --force-yes curl

RUN curl -O http://downloads.typesafe.com/typesafe-activator/1.3.6/typesafe-activator-1.3.6.zip 
RUN apt-get install unzip
RUN unzip typesafe-activator-1.3.6.zip -d / && rm typesafe-activator-1.3.6.zip && chmod a+x /activator-dist-1.3.6/activator
ENV PATH $PATH:/activator-dist-1.3.6

EXPOSE 9000 8888
RUN mkdir /app
WORKDIR /app

CMD ["activator", "run"]


