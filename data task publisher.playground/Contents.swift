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

enum HTTPError: Error {
    case nonHttpResponse
    case requestFailed(Int)
    case networkingError(URLError)
    
    var description: String {
        switch self {
        case .nonHttpResponse:
            return "Non HTTP URL Response received"
        case .requestFailed(let status):
            return "Received HTTP \(status)"
        case .networkingError(let error):
            return "Networking Error: \(error)"
        }
    }
}

func fetchData() -> AnyPublisher<String?, Never> {
    session.dataTaskPublisher(for: url)
        .print()
        .map { $0.data }
        .replaceError(with: Data())
        .map { String(data: $0, encoding: .utf8) }
        .eraseToAnyPublisher()
}

print("getting publisher...")

let publisher = fetchData()

var cancellable: AnyCancellable?

DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
    cancellable = publisher.sink { response in
        print(response ?? "<no body>")
    }
}
