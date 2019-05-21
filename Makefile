.PHONY: test release clean version login logout

version:
	@ echo '{"Version": "${APP_VERSION}"}'

ecr-login:
	 $$(aws ecr get-login --no-include-email)

logout:
	docker logout https://198079243873.dkr.ecr.us-east-1.amazonaws.com

release:
	docker-compose build --pull release
	docker-compose run app bundle
	docker-compose up --abort-on-container-exit codebuild

clean:
	 docker-compose down -v
	 docker images -q -f dangling=true -f label=application=example-api| xargs -I ARGS docker rmi -f ARGS

publish:
	docker-compose push release app
