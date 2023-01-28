FROM golang:1.18 AS builder
ADD ./ /go/src/build/
WORKDIR /go/src/build
RUN go env -w GOPROXY=https://proxy.golang.com.cn,https://goproxy.cn,direct
RUN CGO_ENABLE=0 GOOS=linux GOARCH=amd64 go build -o main .

FROM alpine:latest
WORKDIR /app/
COPY --from=builder /go/src/build/app ./
EXPOSE 8080
ENTRYPOINT [ "./main" ]
