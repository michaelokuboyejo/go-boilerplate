FROM golang:1.12.6 AS builder
ENV GO111MODULE=on
WORKDIR /go/src/github.com/michaelokuboyejo/app
COPY . .
RUN make build

FROM ubuntu:bionic
COPY --from=builder /go/src/github.com/michaelokuboyejo/app/out/ /
EXPOSE 8000
ENTRYPOINT ["service-name"]
