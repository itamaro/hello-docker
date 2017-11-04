REPO=itamarost
PI_ITERS=1000000

pi-python:
	cd one-off/pi-python && \
	docker build -t "${REPO}/pi:py" . && \
	echo "Running Pi:Python with ${PI_ITERS} iterations" && \
	docker run --rm "${REPO}/pi:py" ${PI_ITERS}

pi-go:
	cd one-off/pi-go && \
	docker build -t "${REPO}/pi:golang" . && \
	echo "Running Pi:Golang with ${PI_ITERS} iterations" && \
	docker run --rm "${REPO}/pi:golang" -iterations ${PI_ITERS}

pi-cpp:
	cd one-off/pi-cpp && \
	docker build -t "${REPO}/pi:cpp" . && \
	echo "Running Pi:CPP with ${PI_ITERS} iterations" && \
	docker run --rm "${REPO}/pi:cpp" ${PI_ITERS}

build-echo-python:
	cd service/echo-py && docker build -t "${REPO}/echo:py" .

echo-python: build-echo-python
	docker run --rm -p 8000:8000 "${REPO}/echo:py"

build-echo-go:
	cd service/echo-go && docker build -t "${REPO}/echo:golang" .

echo-go: build-echo-go
	docker run --rm -p 8090:8090 "${REPO}/echo:golang" -port 8090

build-echo-cpp:
	cd service/echo-cpp && docker build -t "${REPO}/echo:cpp" .

echo-cpp: build-echo-cpp
	docker run --rm -p 6767:6767 "${REPO}/echo:cpp"

push: pi-python pi-go pi-cpp build-echo-python build-echo-go build-echo-cpp
	docker push "${REPO}/pi:py"
	docker push "${REPO}/pi:golang"
	docker push "${REPO}/pi:cpp"
	docker push "${REPO}/echo:py"
	docker push "${REPO}/echo:golang"
	docker push "${REPO}/echo:cpp"
