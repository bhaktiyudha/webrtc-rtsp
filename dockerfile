FROM golang:1.15-alpine as build-env
# Git is required for fetching the dependencies.
RUN apk update && apk add --no-cache git
RUN apk add --no-cache tzdata
RUN apk add build-base
# All these steps will be cached
WORKDIR /app
COPY go.mod .
COPY go.sum .

# Get dependancies - will also be cached if we won't change mod/sum
RUN go mod download
# COPY the source code as the last step
COPY . .
# Build the binary
#RUN CGO_ENABLED=1 GOOS=linux GOARCH=arm64 go build -a -installsuffix cgo -o /g$
#RUN apk add --update --no-cache ca-certificates git
RUN go build -o ./bin/rtspwebrtc .

FROM alpine:3.12.2
RUN apk add --no-cache tzdata
WORKDIR /app
COPY --from=build-env /app/bin/rtspwebrtc ./
EXPOSE 3008
ENTRYPOINT ["./rtspwebrtc"]
