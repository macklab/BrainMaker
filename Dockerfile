# Use Ubuntu 16.04
FROM ubuntu:16.04

# Update apt-get, not sure if I actually need this
RUN apt-get update

# The url to download blender
ENV BLENDER_URL https://mirror.clarkson.edu/blender/release/Blender2.79/blender-2.79b-linux-glibc219-x86_64.tar.bz2

# Download and unpack blender into its own directory
RUN mkdir blender && \
  wget BLENDER_URL && \
  tar -jxvf blender-* --strip-components=1 -C blender && \
  rm blender-*

# The url for freesurfer
ENV FREESURFER_URL ftp://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/6.0.0/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz

# Download and unpack freesurfer into its own directory
RUN mkdir freesurfer && \
  wget FREESURFER_URL && \
  tar -xzvf freesurfer-* --strip-components=1 -C freesurfer && \
  rm freesurfer-*

# The url for slic3r
ENV SLIC3R_URL https://dl.slic3r.org/linux/slic3r-linux-x86-1-2-9-stable.tar.gz

# Download and unpack slic3r into its own directory
RUN mkdir slic3r && \
  wget SLIC3R_URL && \
  tar -xzvg slic3r-* --strip-components=1 -C slic3r && \
  rm slic3r-*

ENTRYPOINT ["BrainMaker"]
