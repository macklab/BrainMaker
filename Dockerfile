# Use Ubuntu 16.04
FROM ubuntu:16.04

# Update apt-get, not sure if I actually need this
RUN apt-get update && \
  apt-get install -y \
    wget \
    tar \
    bzip2 \
    libgomp1 \
    libglu1 \
    libxi6 \
    libfreetype6 \
    libxrender1 \
    libgtk2.0-0 \
    libsm6

# The url to download blender
ENV BLENDER_URL https://mirror.clarkson.edu/blender/release/Blender2.79/blender-2.79b-linux-glibc219-x86_64.tar.bz2

# Download and unpack blender into its own directory
RUN mkdir /usr/local/blender && \
  wget $BLENDER_URL && \
  tar -jxvf blender-* --strip-components=1 -C /usr/local/blender && \
  rm blender-*

# The url for freesurfer
ENV FREESURFER_URL ftp://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/6.0.0/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz

# Download and unpack freesurfer into its own directory
RUN mkdir /usr/local/freesurfer && \
  wget $FREESURFER_URL && \
  tar -xzvf freesurfer-* --strip-components=1 -C /usr/local/freesurfer && \
  rm freesurfer-*

# The url for slic3r
ENV SLIC3R_URL https://github.com/prusa3d/Slic3r/releases/download/version_1.39.1/Slic3r-1.39.1-prusa3d-linux64-full-201803010854.tar.bz2

# Download and unpack slic3r into its own directory
RUN mkdir /usr/local/slic3r && \
  wget $SLIC3R_URL && \
  tar -jxvf Slic3r-* --strip-components=1 -C /usr/local/slic3r && \
  rm Slic3r-*

ADD BrainMaker.sh /usr/local/BrainMaker.sh
ADD BrainMaker.py /usr/local/BrainMaker.py
ADD BrainMaker.ini /usr/local/BrainMaker.ini
ADD license.txt /usr/local/freesurfer/license.txt
RUN chmod +x /usr/local/BrainMaker.sh

VOLUME /data
VOLUME /ouputs
ENTRYPOINT ["/usr/local/BrainMaker.sh"]
