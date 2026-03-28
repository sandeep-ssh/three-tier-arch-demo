#
# Build
#
FROM --platform=linux/arm64 golang:1.23 AS build

WORKDIR /go/src/app

COPY *.go .

RUN go mod init dispatch && go get
RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -a -ldflags '-extldflags "-static"' -o /dispatch .

#
# Run
#
FROM --platform=linux/arm64 gcr.io/distroless/static-debian12

COPY --from=build /dispatch /dispatch

CMD ["/dispatch"]
