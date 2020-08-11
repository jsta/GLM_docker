FROM ubuntu:latest

MAINTAINER "Joseph Stachelek" stachel2@msu.edu

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
	gfortran-8 \
	gfortran \ 
	libgd-dev \
	git \
	build-essential \
	libnetcdf-dev \
	ca-certificates \
	&& update-ca-certificates

RUN git clone -b v3.1.0 https://github.com/AquaticEcoDynamics/GLM && \
	git clone https://github.com/AquaticEcoDynamics/libplot && \
	git clone https://github.com/AquaticEcoDynamics/libutil && \
	git clone https://github.com/AquaticEcoDynamics/libaed2

WORKDIR libutil

RUN F90=gfortran-8 make

WORKDIR ../libplot

RUN make

WORKDIR ../libaed2

RUN F90=gfortran-8 make

WORKDIR ../GLM

RUN ./build_glm.sh
