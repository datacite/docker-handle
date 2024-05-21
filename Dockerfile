
FROM phusion/baseimage:jammy-1.0.4
LABEL Name=handle_svr Version=0.0.2

## Image config

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Update installed APT packages
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN apt-get install -y ntp wget openjdk-11-jdk python3 mysql-client libmariadb-java

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## Handle Server setup

# Get the handle server package and put it in the container
ADD http://handle.net/hnr-source/handle-9.3.1-distribution.tar.gz /tmp/
RUN mkdir -p /opt/handle && tar xf /tmp/handle-9.3.1-distribution.tar.gz -C /opt/handle --strip-components=1

# Add the jdbc connector so it gets loaded
RUN ln -s /usr/share/java/mariadb-java-client.jar /opt/handle/lib/mariadb-java-client.jar

# Copy over the handle base configs and build script
COPY handle/ /home/handle/

# Create the working directory for the handle server that will run in the container
RUN mkdir -p /var/handle/svr/logs

# Redirect log files to stdout/stderr
RUN ln -sf /dev/stdout /var/handle/svr/logs/access.log \
    && ln -sf /dev/stderr /var/handle/svr/logs/error.log

# Install Handle server as a service
RUN mkdir /etc/service/handle
COPY handle.sh /etc/service/handle/run
RUN chmod +x /etc/service/handle/run
