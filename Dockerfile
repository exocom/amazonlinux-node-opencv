FROM exocom/amazonlinux-node:6.10.3

ENV OPENCV_VERSION 3.3.0

RUN yum update -y \
      && yum install -y unzip cmake

RUN mkdir -p /usr/local/src/opencv-${OPENCV_VERSION}/release

RUN cd /usr/local/src \
    && curl -s -L -O https://github.com/itseez/opencv/archive/${OPENCV_VERSION}.zip \
    && unzip ${OPENCV_VERSION}.zip \
    && cd /usr/local/src/opencv-${OPENCV_VERSION}/release \
    && cmake -D CMAKE_BUILD_TYPE=RELEASE -D WITH_IPP=ON -D INSTALL_CREATE_DISTRIB=ON .. \
    && make && make install \
    && cd /usr/local/src && rm ${OPENCV_VERSION}.zip

ENV LD_LIBRARY_PATH /usr/local/lib
ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig
