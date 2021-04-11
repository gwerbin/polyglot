build-dev: server

build-release: release/server

run-dev: server
	./server

clean:
	rm -rf ./server ./release/

server: server.cr
	crystal build --progress --debug -o $@ $^

release/server: server.cr 
	mkdir -p release/
	crystal build --progress --release -o $@ $^
