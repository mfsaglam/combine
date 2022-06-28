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

func exampleFlatMap() {
    urls.publisher
        .flatMap(maxPublishers: .max(2)) {
            URLSession.shared.dataTaskPublisher(for: $0)
                .assertNoFailure()
        }
        .sink { data, response in
            print("Received \(data.count) bytes from \(response.url!)")
        }
        .store(in: &cancellables)
}

exampleFlatMap()
