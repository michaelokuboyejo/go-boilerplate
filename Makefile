NO_COLOR=\033[0m
OK_COLOR=\033[32;01m
ERROR_COLOR=\033[31;01m
WARN_COLOR=\033[33;01m

BINARY_NAME?=app
GO_LINKER_FLAGS=-ldflags "-s"
DIR_OUT=$(CURDIR)/out

# detecting GOPATH and removing trailing "/" if any
GOPATH = $(realpath $(shell go env GOPATH))
GO ?= "go"
export GO111MODULE=on

clean:
	@printf "$(OK_COLOR)==> Cleaning project$(NO_COLOR)\n"
	rm -f ${DIR_OUT}/${BINARY_NAME}

deps:
	@printf "$(OK_COLOR)==> Installing dependencies$(NO_COLOR)\n"
	@go mod tidy
	@go mod vendor

lint:
	@printf "$(OK_COLOR)==> Linting$(NO_COLOR)\n"
	@golangci-lint run

build:
	@printf "$(OK_COLOR)==> Building . . .$(NO_COLOR)\n"
	@go build -o ${DIR_OUT}/${BINARY_NAME} ${GO_LINKER_FLAGS}


#---------------
#-- tests
#---------------
.PHONY: tests test-integration test-unit
tests: test-integration test-unit

test-integration: tools.format tools.vet
	@command -v godog >/dev/null ; if [ $$? -ne 0 ]; then \
			echo "--> installing godog"; \
	@go get github.com/DATA-DOG/godog/cmd/godog; \
	fi

	@printf "$(OK_COLOR)==> Spinning up docker-compose$(NO_COLOR)\n"
	@docker-compose up -d

	@printf "$(OK_COLOR)==> Running integration tests$(NO_COLOR)\n"
	@go test -godog -stop-on-failure

test-unit:
	@printf "$(OK_COLOR)==> Unit Testing$(NO_COLOR)\n"
	@go test -v -race ./... -covermode=atomic -coverprofile=unit.coverprofile 


