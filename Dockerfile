FROM quay.io/samsung_cnct/golang:1.16.4-alpine as build
ENV GO111MODULE on
ENV CGO_ENABLED 0
RUN mkdir -p /out/usr/bin
WORKDIR /protolock
COPY . .
RUN go test -v ./...
RUN go build -o protolock ./cmd/protolock/*.go
RUN cp protolock /out/usr/bin/protolock

FROM scratch
COPY --from=build /out/ .
ENTRYPOINT ["/usr/bin/protolock"]
