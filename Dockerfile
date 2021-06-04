# Dockerfile.controller
#
# Dockerfile for the controller and worker nodes. DB is separate.

FROM ubuntu:20.04

RUN	useradd -ms /bin/bash -p scan -u 10000 scan && \
	usermod -aG sudo scan && \
    	adduser scan sudo &&\
    	echo "scan:scan" | chpasswd && \
	apt-get update &&\
	DEBIAN_FRONTEND="noninteractive" \
	apt-get install -y \
		wget \
		sudo \
		python3 \
		python3-pip \
		vim && \
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
	DEBIAN_FRONTEND="noninteractive" \
	apt install -y ./google-chrome-stable_current_amd64.deb

USER scan
ADD --chown=scan:scan . /home/scan/

RUN	pip3 install -r /home/scan/requirements.txt && \
	mkdir -p /home/scan/webxray/resources/policyxray/ && \
	cd /home/scan/webxray/resources/policyxray/ && \
	wget https://raw.githubusercontent.com/mozilla/readability/master/Readability.js && \
	cd /home/scan

