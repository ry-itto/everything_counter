SWIFT_RUN=swift run -c release --package-path Tools
WORKSPACE=EverythingCounter.xcworkspace

.PHONY: open
open:
	open $(WORKSPACE)


.PHONY: test
test:
	@xcodebuild test \
	    -workspace $(WORKSPACE) \
	    -scheme AppPackageTests \
	    -destination 'platform=iOS Simulator,OS=14.4,name=iPhone 12 Pro Max' \
	    | bundle exec xcpretty

# SwiftFormat
.PHONY: run-swiftformat
run-swiftformat:
	$(SWIFT_RUN) swiftformat .
