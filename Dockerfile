# daemon runs in the background
# run something like tail /var/log/azurd/current to see the status
# be sure to run with volumes, ie:
# docker run -v $(pwd)/azurd:/var/lib/azurd -v $(pwd)/wallet:/home/azur --rm -ti azur:0.2.2
ARG base_image_version=0.10.0
FROM phusion/baseimage:$base_image_version

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.2.2/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

ADD https://github.com/just-containers/socklog-overlay/releases/download/v2.1.0-0/socklog-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/socklog-overlay-amd64.tar.gz -C /

ARG TURTLECOIN_BRANCH=master
ENV TURTLECOIN_BRANCH=${TURTLECOIN_BRANCH}

# install build dependencies
# checkout the latest tag
# build and install
RUN apt-get update && \
    apt-get install -y \
      build-essential \
      python-dev \
      gcc-4.9 \
      g++-4.9 \
      git cmake \
      libboost1.58-all-dev && \
    git clone https://github.com/azur/azur.git /src/azur && \
    cd /src/azur && \
    git checkout $TURTLECOIN_BRANCH && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_CXX_FLAGS="-g0 -Os -fPIC -std=gnu++11" .. && \
    make -j$(nproc) && \
    mkdir -p /usr/local/bin && \
    cp src/azurd /usr/local/bin/azurd && \
    cp src/walletd /usr/local/bin/walletd && \
    cp src/zedwallet /usr/local/bin/zedwallet && \
    cp src/miner /usr/local/bin/miner && \
    strip /usr/local/bin/azurd && \
    strip /usr/local/bin/walletd && \
    strip /usr/local/bin/zedwallet && \
    strip /usr/local/bin/miner && \
    cd / && \
    rm -rf /src/azur && \
    apt-get remove -y build-essential python-dev gcc-4.9 g++-4.9 git cmake libboost1.58-all-dev librocksdb-dev && \
    apt-get autoremove -y && \
    apt-get install -y  \
      libboost-system1.58.0 \
      libboost-filesystem1.58.0 \
      libboost-thread1.58.0 \
      libboost-date-time1.58.0 \
      libboost-chrono1.58.0 \
      libboost-regex1.58.0 \
      libboost-serialization1.58.0 \
      libboost-program-options1.58.0 \
      libicu55

# setup the azurd service
RUN useradd -r -s /usr/sbin/nologin -m -d /var/lib/azurd azurd && \
    useradd -s /bin/bash -m -d /home/azur azur && \
    mkdir -p /etc/services.d/azurd/log && \
    mkdir -p /var/log/azurd && \
    echo "#!/usr/bin/execlineb" > /etc/services.d/azurd/run && \
    echo "fdmove -c 2 1" >> /etc/services.d/azurd/run && \
    echo "cd /var/lib/azurd" >> /etc/services.d/azurd/run && \
    echo "export HOME /var/lib/azurd" >> /etc/services.d/azurd/run && \
    echo "s6-setuidgid azurd /usr/local/bin/azurd" >> /etc/services.d/azurd/run && \
    chmod +x /etc/services.d/azurd/run && \
    chown nobody:nogroup /var/log/azurd && \
    echo "#!/usr/bin/execlineb" > /etc/services.d/azurd/log/run && \
    echo "s6-setuidgid nobody" >> /etc/services.d/azurd/log/run && \
    echo "s6-log -bp -- n20 s1000000 /var/log/azurd" >> /etc/services.d/azurd/log/run && \
    chmod +x /etc/services.d/azurd/log/run && \
    echo "/var/lib/azurd true azurd 0644 0755" > /etc/fix-attrs.d/azurd-home && \
    echo "/home/azur true azur 0644 0755" > /etc/fix-attrs.d/azur-home && \
    echo "/var/log/azurd true nobody 0644 0755" > /etc/fix-attrs.d/azurd-logs

VOLUME ["/var/lib/azurd", "/home/azur","/var/log/azurd"]

ENTRYPOINT ["/init"]
CMD ["/usr/bin/execlineb", "-P", "-c", "emptyenv cd /home/azur export HOME /home/azur s6-setuidgid azur /bin/bash"]
