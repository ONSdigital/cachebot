APP_NAME?=cachebot-test
APP_BINARY=cachebot_linux_amd64
ZIP_FILE=cachebot.zip
EB_CONFIG=.elasticbeanstalk/config.yml

.PHONY: all
all:
	GOOS="linux" GOARCH="amd64" go build -o $(APP_BINARY) main.go
	zip $(ZIP_FILE) $(APP_BINARY) Dockerfile

.PHONY: audit
audit:
	go list -m all | nancy sleuth

VARS ?= CF_TOKEN=$(CF_TOKEN) CF_ZONE=$(CF_ZONE) SLACK_TOKEN=$(SLACK_TOKEN) GOFIGURE_ENV_ARRAYS=1 URL_BASES=https://www.ons.gov.uk,https://cy.ons.gov.uk URL_SUFFIXES=pdf,data

.PHONY: debug
debug:
	TRIGGER_PHRASE="zap that cache" $(VARS) go run main.go

init: create deploy setenv

.PHONY: create
create:
	eb create $(APP_NAME) --single --instance_type t2.micro

.PHONY: setenv
setenv:
	eb setenv $(VARS)

# for 'eb deploy' we need to specify the artifact in the config, this will add it
.PHONY: eb-config
eb-config:
	[[ "$(shell yq '.deploy.artifact' $(EB_CONFIG))" == "$(ZIP_FILE)" ]] || yq -i '.deploy.artifact = "$(ZIP_FILE)"' $(EB_CONFIG)

.PHONY: deploy
deploy: eb-config
	eb deploy $(APP_NAME) --staged

.PHONY: clean
clean:
	rm $(ZIP_FILE) $(APP_BINARY)
