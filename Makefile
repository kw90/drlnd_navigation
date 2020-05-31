# --------------------------------------------------------------------
# Copyright (c) 2020 Saarbrücken, Germany. All Rights Reserved.
# Author(s): Kai Waelti
#
# Credit to: Anthony Potappel for inspiration
# https://itnext.io/docker-makefile-x-ops-sharing-infra-as-code-parts-ea6fa0d22946
# This software may be modified and distributed under the terms of the
# MIT license. See the LICENSE file for details.
# --------------------------------------------------------------------

# If you see pwd_unknown showing up, this is why. Re-calibrate your system.
PWD ?= pwd_unknown

# PROJECT_NAME defaults to name of the current directory.
# should not to be changed if you follow GitOps operating procedures.
PROJECT_NAME = $(notdir $(PWD))

# if vars not set specifially: try default to environment, else fixed value.
# strip to ensure spaces are removed in future editorial mistakes.
# tested to work consistently on popular Linux flavors and Mac.
ifeq ($(user),)
# USER retrieved from env, UID from shell.
HOST_USER ?= $(strip $(if $(USER),$(USER),nodummy))
HOST_UID ?= $(strip $(if $(shell id -u),$(shell id -u),4000))
else
# allow override by adding user= and/ or uid=  (lowercase!).
# uid= defaults to 0 if user= set (i.e. root).
HOST_USER = $(user)
HOST_UID = $(strip $(if $(uid),$(uid),0))
endif

THIS_FILE := $(lastword $(MAKEFILE_LIST))
#CMD_ARGUMENTS ?= $(cmd)
NB_TOKEN ?= abcd

SHELL=/bin/bash
CONDA_ACTIVATE=source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate


# export such that its passed to shell functions for Docker to pick up.
export PROJECT_NAME
export HOST_USER
export HOST_UID

# all our targets are phony (no files to check).
.PHONY: build remove 

.INTERMEDIATE: remove

install:
	conda create --name drlnd_nav python=3.6
	($(CONDA_ACTIVATE) drlnd_nav ; python --version)
	pip install -r $(PWD)/requirements.txt
	python -m ipykernel install --user --name drlnd_nav --display-name "drlnd_nav"

start:
	($(CONDA_ACTIVATE) drlnd_nav ; jupyter notebook --ip=127.0.0.1 --port=8888 --NotebookApp.token='$(NB_TOKEN)' --NotebookApp.password='')

# remove:
# 	docker stop pandoc-latex && docker rm pandoc-latex

prune:
	docker system prune -a
