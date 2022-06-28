import Foundation
import Combine
import PlaygroundSupport

//flatMap and switchToLatest

PlaygroundPage.current.needsIndefiniteExecution = true

let urls = [
    "https://combineswift.com",
    "https://apple.com",
    "https://twitter.com"
].map { URL(string: $0)! }

var cancellables: Set<AnyCancellable> = []
