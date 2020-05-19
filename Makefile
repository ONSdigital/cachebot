all:
	cd /tmp && go get github.com/mitchellh/gox; cd -
	gox -osarch="linux/amd64" -output="cachebot_linux_amd64"
	zip cachebot.zip cachebot_linux_amd64 Dockerfile

.PHONY: all
