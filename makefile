.PHONY: build-echo build-next

build-next:
	@read -p "Enter the tag for the image: " TAG && \
	ACCOUNT_ID=$(shell docker compose exec aws sh -c 'aws sts get-caller-identity --query Account --output text') && \
	docker build -f ./environment/docker/next/Dockerfile -t next . && \
	docker tag next:latest $$ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com/next:$$TAG && \
	docker compose exec aws sh -c 'aws ecr get-login-password --region ap-northeast-1' | docker login --username AWS --password-stdin $$ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com && \
	docker push $$ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com/next:$$TAG

build-echo:
	@read -p "Enter the tag for the image: " TAG && \
	ACCOUNT_ID=$(shell docker compose exec aws sh -c 'aws sts get-caller-identity --query Account --output text') && \
	docker build -f ./environment/docker/echo/Dockerfile -t echo . && \
	docker tag echo:latest $$ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com/echo:$$TAG && \
	docker compose exec aws sh -c 'aws ecr get-login-password --region ap-northeast-1' | docker login --username AWS --password-stdin $$ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com && \
	docker push $$ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com/echo:$$TAG

