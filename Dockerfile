# Use Ubuntu 16.04
FROM ubuntu:16.04

# Get Linux dependencies
RUN apt-get update && \
  apt-get install -y \
    curl \
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
  curl -ssL $BLENDER_URL | tar -jxv --strip-components=1 -C /usr/local/blender

# The url for freesurfer
ENV FREESURFER_URL ftp://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/6.0.0/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz

# Download and unpack freesurfer into its own directory
RUN mkdir /usr/local/freesurfer && \
  curl -ssL $FREESURFER_URL | tar -xzv --strip-components=1 -C /usr/local/freesurfer \
  --exclude='freesurfer/trctrain' \
  --exclude='freesurfer/subjects/fsaverage_sym' \
  --exclude='freesurfer/subjects/fsaverage3' \
  --exclude='freesurfer/subjects/fsaverage4' \
  --exclude='freesurfer/subjects/fsaverage5' \
  --exclude='freesurfer/subjects/fsaverage6' \
  --exclude='freesurfer/subjects/cvs_avg35' \
  --exclude='freesurfer/subjects/cvs_avg35_inMNI152' \
  --exclude='freesurfer/subjects/bert' \
  --exclude='freesurfer/subjects/V1_average' \
  --exclude='freesurfer/average/mult-comp-cor' \
  --exclude='freesurfer/lib/cuda' \
  --exclude='freesurfer/lib/qt'

# The url for slic3r
ENV SLIC3R_URL https://github.com/prusa3d/Slic3r/releases/download/version_1.39.1/Slic3r-1.39.1-prusa3d-linux64-full-201803010854.tar.bz2

# Download and unpack slic3r into its own directory
RUN mkdir /usr/local/slic3r && \
  curl -ssL $SLIC3R_URL | tar -jxv --strip-components=1 -C /usr/local/slic3r

# Add scripts to correct location
ADD BrainMaker.sh /usr/local/BrainMaker.sh
ADD blender_default.py /usr/local/blender_default.py
ADD slicer_default.ini /usr/local/slicer_default.ini

# Allow execution from this shell script
RUN chmod +x /usr/local/BrainMaker.sh

# Setup freesurfer
ENV FREESURFER_HOME /usr/local/freesurfer
ENV PATH $FREESURFER_HOME/bin:$PATH

# Create volumes to be mounted
VOLUME /data
VOLUME /outputs
VOLUME /configs

ENTRYPOINT ["/usr/local/BrainMaker.sh"]
