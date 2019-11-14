CONTAINER_NAME = venkatperi/docker-asdf:latest
DEPS = 

#-----------------------------------------------------------------------------
# default target
#-----------------------------------------------------------------------------

all   : ## Build the container - this is the default action
all: build

#-----------------------------------------------------------------------------
# build container
#-----------------------------------------------------------------------------

.built: . $(DEPS)
	docker build -t $(CONTAINER_NAME) .
	@docker inspect -f '{{.Id}}' $(CONTAINER_NAME) > .built

build : ## build the container
build: .built
 
clean : ## delete the image from docker
clean: 
	@$(RM) .built
	-docker rmi $(CONTAINER_NAME)

re    : ## clean and rebuild
re: clean all

#-----------------------------------------------------------------------------
# supporting targets
#-----------------------------------------------------------------------------

help  : ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

.PHONY : all build clean re help

