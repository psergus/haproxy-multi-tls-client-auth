DOCKER_IMAGE ?= haproxy-tls-client-auth
DOCKER_CONTAINER ?= haproxy-tls-client-auth
# The command below will extract the branch name and replace slashes for underscores so that
# it can be used as a valid docker image tag.
BRANCH_NAME ?= `git log --pretty=format:'%h' -n 1`
VOLUME ?=-v $(PWD)/lib:/etc/haproxy
ENV_FILE ?= .env


PHONY: login image

image:
	$(HIDE)docker build -f Dockerfile -t $(DOCKER_IMAGE) $(PWD)

run:
	$(HIDE)docker run --rm \
  --name $(DOCKER_CONTAINER) \
  -p 443:443/tcp \
	--env-file=$(ENV_FILE) \
  $(VOLUME) \
  $(DOCKER_IMAGE) \
  haproxy -f /etc/haproxy/haproxy.cfg

reload:
	$(HIDE)docker exec -it \
  $(DOCKER_CONTAINER) \
  haproxy reload

enter:
	$(HIDE)docker exec -it $(DOCKER_CONTAINER) bash
