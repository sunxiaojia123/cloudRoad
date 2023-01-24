FROM golang:1.18
ADD ./ /go/src/cloudRoad/
WORKDIR /go/src/cloudRoad
RUN go env -w GOPROXY=https://proxy.golang.com.cn,https://goproxy.cn,direct
RUN CGO_ENABLE=0 GOOS=linux GOARCH=amd64 go build -o app .

FROM alpine:latest
WORKDIR /app/
COPY --from=0 /go/src/cloudRoad/app ./
COPY --from=0 /go/src/cloudRoad/config ./
EXPOSE 8080
ENTRYPOINT [ "./app" ]
