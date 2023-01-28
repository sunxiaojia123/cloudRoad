FROM golang:1.18 as builder
RUN mkdir /build
ADD . /build/
WORKDIR /build
RUN go env -w GOPROXY=https://proxy.golang.com.cn,https://goproxy.cn,direct
RUN CGO_ENABLE=0 GOOS=linux GOARCH=amd64 go build -o main .

FROM alpine:latest
RUN mkdir /app
COPY --from=builder /build/main /app/
COPY --from=builder /build/config /app/
WORKDIR /app
EXPOSE 8080
ENTRYPOINT [ "./main" ]
