FROM golang:alpine as builder
RUN mkdir /build
ADD . /build/
WORKDIR /build
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o main  .

FROM alpine
LABEL maintainer="hayderimran7@gmail.com"
RUN adduser -S -D -H -h /app appuser
USER appuser
COPY --from=builder /build/main /app/
WORKDIR /app
COPY templates templates

ENV APP_MESSAGE="Welcome this is the new s#@&!"

EXPOSE 8080/tcp
CMD ["./main"]
