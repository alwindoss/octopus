# Makefile for go program
.PHONY:	all proto build run test client server kill make usage

PROTOC=/usr/local/bin/protoc
PROGRAM=octopus
BINARYNAME=octopus
SERVICE=orchestrator_service

all: usage


proto p:
	$(PROTOC) -I./proto ./proto/*.proto --go_out=plugins=grpc:proto
	@ls -al ./proto

build b:
	make clean
	make proto
	go build -o octopus

rebuild:
	make proto
	make build

run r:
	./octopus &

server rs:
	./server/server &

kill k:
	killall $(BINARYNAME)

test t:
	go test

clean:
	rm -fv octopus
	rm -fv proto/*.go

usage:
	@echo ""
	@echo "Makefile for $(PROGRAM)"
	@echo ""
	@echo "make [proto|build|run|kill|test]"
	@echo "   - proto : compile interface spec"
	@echo "   - build : compile octopus"
	@echo "   - run   : start the server and exec client"
	@echo "   - kill  : stop the server"
	@echo ""
