import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/// # Data Task Publishers

let session = URLSession.shared

let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!

func example1() {
    // Output = (data: Data, response: URLResponse)
    // Failure = URLError
    var cancellable: AnyCancellable?
    cancellable = session.dataTaskPublisher(for: url)
        .print()
        .map { $0.data }
        .replaceError(with: Data())
        .map { String(data: $0, encoding: .utf8) }
        .sink { response in
            print("response \(response ?? "<no body>")")
            cancellable = nil
            _ = cancellable
        }
}

example1()
