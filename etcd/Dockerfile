FROM ubuntu:13.04

RUN apt-get update -q
RUN apt-get install -qy build-essential curl git
RUN curl -s https://go.googlecode.com/files/go1.2.src.tar.gz | tar -v -C /usr/local -xz
RUN cd /usr/local/go/src && ./make.bash --no-clean 2>&1
ENV PATH /usr/local/go/bin:$PATH

RUN git clone https://github.com/coreos/etcd.git /opt/etcd
RUN cd /opt/etcd && git checkout tags/v0.3.0

RUN cd /opt/etcd && ./build

EXPOSE 4001 7001
VOLUME /opt/etcd/

ENTRYPOINT ["/opt/etcd/bin/etcd"]

CMD /opt/etcd/bin/etcd

# To run just do the following
# docker run -i -p 4001:4001 -p 7001:7001 -v /opt/etcd_data:/opt/etcd/data -t melgray/etcd
