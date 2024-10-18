build:
	docker buildx build --platform linux/amd64 --tag varunmittal91/python-build --progress=plain . 
publish: build
	docker push varunmittal91/python-build
all: publish
