SWIFT_BUILD=swift build -c release --package-path Tools
SWIFT_BUILD_PRODUCT=swift build -c release --package-path Tools --product
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

# Swift Package Build
.PHONY: package-build-all
package-build-all:
	$(SWIFT_BUILD)


.PHONY: package-build-swiftlint
package-build-swiftlint:
	$(SWIFT_BUILD_PRODUCT) swiftlint

# SwiftFormat
.PHONY: run-swiftformat
run-swiftformat:
	$(SWIFT_RUN) swiftformat .
