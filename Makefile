WORKSPACE=EverythingCounter.xcworkspace

.PHONY: open
open:
	open $(WORKSPACE)


.PHONY: test
test:
	@xcodebuild test \
	    -workspace $(WORKSPACE) \
	    -scheme AppPackageTests \
	    -destination 'platform=iOS Simulator,OS=14.2,name=iPhone 12 Pro Max' \
	    | bundle exec xcpretty
