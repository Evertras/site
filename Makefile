# Default just downloads everything we might want for now
.PHONY: default
default: \
	bin/terraform \
	bin/hugo \
	node_modules

lint: node_modules
	npx prettier --check .

main-serve: bin/hugo
	cd main && hugo server

# For now we only support Linux 64 bit and MacOS for simplicity
ifeq ($(shell uname), Darwin)
OS_URL := darwin
else
OS_URL := linux
endif

################################################################################
# Local tooling
#
# This section contains tools to download to the local ./bin directory for easy
# local use.  The .envrc file makes adding the local ./bin directory to our path
# simple, so we can use tools here without having to install them globally as if
# they actually were global.

# Terraform manages our infrastructure
bin/terraform:
	mkdir -p bin
	curl -Lo bin/terraform.zip https://releases.hashicorp.com/terraform/1.3.2/terraform_1.3.2_$(OS_URL)_amd64.zip
	cd bin && unzip terraform.zip
	rm bin/terraform.zip

# Hugo is a static site generator
bin/hugo:
	mkdir -p bin
ifeq ($(OS_URL), darwin)
	curl -Lo bin/hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v0.104.3/hugo_0.104.3_darwin-universal.tar.gz
else
	curl -Lo bin/hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v0.104.3/hugo_0.104.3_linux-amd64.tar.gz
endif
	cd bin && tar -xzvf hugo.tar.gz && rm README.md && rm LICENSE && rm *.tar.gz

node_modules: package-lock.json
	npm install
