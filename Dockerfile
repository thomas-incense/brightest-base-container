FROM python:3.8.10

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    software-properties-common \
    build-essential \
    python-all-dev \
    libpq-dev \
    libgeos-dev \
    wget \
    curl \
    sqlite3 \
    libtiff-dev \
    libsqlite3-dev \
    libcurl4-openssl-dev \
    pkg-config

RUN wget https://cmake.org/files/v3.12/cmake-3.12.2-Linux-x86_64.tar.gz \
    && tar -zxvf cmake-3.12.2-Linux-x86_64.tar.gz \
    && mv cmake-3.12.2-Linux-x86_64 cmake-3.12.2 \
    && ln -sf /cmake-3.12.2/bin/* /usr/bin


# This is just an example with hard-coded paths/uris and no cleanup...
RUN curl -k https://download.osgeo.org/proj/proj-8.2.1.tar.gz | tar -xz &&\
    cd proj-8.2.1 &&\
    mkdir build &&\
    cd build && \
    cmake .. &&\
    make && \
    make install

RUN wget http://download.osgeo.org/gdal/3.4.0/gdal-3.4.0.tar.gz
RUN tar xvfz gdal-3.4.0.tar.gz
WORKDIR ./gdal-3.4.0
RUN ./configure --with-python --with-pg --with-geos &&\
    make && \
    make install && \
    ldconfig

RUN curl --silent --location https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y \
    nodejs

RUN apt-get update

RUN pip install --upgrade pip
RUN pip install gdal

WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install -r requirements.txt
RUN npm install -g npm@8.19.1

# Update C env vars so compiler can find gdal
ENV CPLUS_INCLUDE_PATH=/usr/include/gdal
ENV C_INCLUDE_PATH=/usr/include/gdal