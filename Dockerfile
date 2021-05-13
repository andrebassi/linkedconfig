FROM golang:1.16 as builder

WORKDIR /operator
COPY go.mod go.mod
COPY go.sum go.sum

RUN go mod vendor

COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GO111MODULE=on go build -a -o linkedconfig main.go


# Use distroless as minimal base image to package the manager binary
# Refer to https://github.com/GoogleContainerTools/distroless for more details
FROM gcr.io/distroless/static:nonroot
WORKDIR /
COPY --from=builder /operator/linkedconfig .
USER nonroot:nonroot

ENTRYPOINT ["/linkedconfig"]