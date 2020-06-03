##################################
# STEP 1 build executable binary #
##################################
FROM golang:alpine AS builder

WORKDIR /go/src/app
COPY soma.go .

#RUN go build soma.go
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /go/bin/soma

CMD ["./soma"]

##################################
# STEP 2 build a small image     #
##################################
FROM scratch

# Copy our static executable.
COPY --from=builder /go/bin/soma /go/bin/soma

# Run the soma binary.
ENTRYPOINT ["/go/bin/soma"]
