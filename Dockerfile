FROM golang:alpine AS builder

RUN apk update
RUN apk add nano
RUN mkdir /home/fullcycle
USER root
COPY hello.go /home/fullcycle

WORKDIR /home/fullcycle
RUN chmod 777 hello.go

RUN go mod init example/hello
RUN go build -o helloexe

FROM scratch

COPY --from=builder /home/fullcycle/helloexe /home/fullcycle/hello
ENTRYPOINT ["/home/fullcycle/hello"]
