#!/bin/bash

###########
## QIIME ##
###########
cd /tmp/
easy_install -U pip
easy_install -U distribute
pip install numpy==1.7.1
pip install qiime
####################
