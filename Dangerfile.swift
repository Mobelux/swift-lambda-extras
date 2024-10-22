import Danger

extension String: Error {}

let danger = Danger()

if danger.github.pullRequest.body == nil {
    danger.fail("Please add a description to this Pull Request")
}

SwiftLint
    .lint(
        .all(directory: nil),
        configFile: ".swiftlint.yml"
    )
