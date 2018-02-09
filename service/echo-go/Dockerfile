# Using multi-stage build to compile in "builder image" and use a slimmer "runtime image" as final artifact

FROM golang:1.9 as builder
WORKDIR /go/src/github.com/itamaro/hello-docker/service/echo-go
COPY echo.go ./
# Need to create 100% static binaries to make it work in scratch / alpine
# https://github.com/golang/go/issues/9344#issuecomment-69944514
RUN CGO_ENABLED=0 go build -a -installsuffix cgo -o echo .

# don't need anything beyond the executable binary in the final image
FROM scratch
WORKDIR /root/
COPY --from=builder /go/src/github.com/itamaro/hello-docker/service/echo-go/echo /usr/bin/
ENTRYPOINT ["echo"]
