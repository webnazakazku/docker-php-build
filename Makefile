NAME = webnazakazku/php-build
VERSION = 0.6.0

.PHONY: all php56 php70 php71 php72 php73 pho74 php80 php81 php82 php83 php84 tag_latest release

all: php56 php70 php71 php72 php73 php80 php81 php82 php83 php84

php56:
	docker build -t $(NAME)-5.6:$(VERSION) --rm -f Dockerfile-5.6 .

php70:
	docker build -t $(NAME)-7.0:$(VERSION) --rm -f Dockerfile-7.0 .

php71:
	docker build -t $(NAME)-7.1:$(VERSION) --rm -f Dockerfile-7.1 .

php72:
	docker build -t $(NAME)-7.2:$(VERSION) --rm -f Dockerfile-7.2 .

php73:
	docker build -t $(NAME)-7.3:$(VERSION) --rm -f Dockerfile-7.3 .

php74:
	docker build -t $(NAME)-7.4:$(VERSION) --rm -f Dockerfile-7.4 .

php80:
	docker build -t $(NAME):8.0 --rm -f Dockerfile-8.0 .

php81:
	docker build -t $(NAME):8.1 --rm -f Dockerfile-8.1 .

php82:
	docker build -t $(NAME):8.2 --rm -f Dockerfile-8.2 .

php83:
	docker build -t $(NAME):8.3 --rm -f Dockerfile-8.3 .

php84:
	docker build -t $(NAME):8.4 --rm -f Dockerfile-8.4 .

tag_latest:
	docker tag -f $(NAME):$(VERSION) $(NAME):latest

release: tag_latest
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! head -n 1 Changelog.md | grep -q 'release date'; then echo 'Please note the release date in Changelog.md.' && false; fi
	docker push $(NAME)
	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"
