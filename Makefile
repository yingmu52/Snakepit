PODSPEC := $(PWD)/Snakepit.podspec
PART ?= patch # minor / major
SEARCH := '(\d+.){2}\d+' 
# use shell to get output of egrep	
CURRENT-VERSION=$(shell egrep -o -m 1 $(SEARCH) $(PODSPEC)) 

pod-deploy:
	@echo 'Deploying to CocoaPod'
	@pod lib lint $(PODSPEC)
	@pod trunk push

bump:
	@echo 'Bumping the fucking version'
	bumpversion --current-version $(CURRENT-VERSION) $(PART) $(PODSPEC)

commit: 
	@git add *
	@git commit -m "Version Bumped: $(CURRENT-VERSION)"
	@git push origin master
	@git tag $(CURRENT-VERSION) 
	@git push origin --tags

bootstrap:
	sudo pip uninstall pip
	sudo easy_install pip
	sudo pip install --upgrade bumpversion
	sudo brew install xctool

test:
	xctool -workspace Snakepit.xcworkspace -scheme Snakepit -sdk iphonesimulator run-tests

release: bump commit pod-deploy
