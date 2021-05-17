### copyright 2017-2021 Regents of the University of California and the Broad Institute. All rights reserved.
FROM genepattern/docker-python36:0.4

MAINTAINER Barbara Hill <bhill@broadinstitute.org>

# While you are debugging/iterating over your module code in the Module integrator comment out the secion below.
# When you are done, export your module, unzip and move your source files into the src directory in this local workspace.
# Then, update this section for you module and build using the docker build command below - again updated for your module.
# Note that you only need to add gpuser if you base image (the image specified in FROM) is run as root. If it runs as another user, you may need to become root (USER root) to add folders...etc. Just make sure to switch back to the non-root user before exiting.
# -----------------------------------
#creating a non-root user - see above
RUN useradd -ms /bin/bash gpuser
USER newuser
WORKDIR /home/newuser

#switch back to root to create dir
USER root
RUN mkdir /ExampleModule \
    && chown gpuser /ExampleModule

#switch to non-root before exiting so that we don't run as root on the server.
USER gpuser
COPY src/*.py /ExampleModule/

RUN /ExampleModule/ExampleModule.py
# -----------------------------------

# docker build --rm https://github.com/genepattern/ExampleModule.git#develop -f Dockerfile -t genepattern/example-module:2
# make sure this repo and tag match the manifest & don't forget to docker push!

# you can use this command to run Docker and iterate locally (update for your paths and module name, of course)
# docker run --rm -it --user gpuser -v /c/Users/MyUSER/PathTo/ExampleModule:/mnt/mydata:rw genepattern/example-module:<tag> bash