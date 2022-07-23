import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

///# Retrying Failed Requests

let session = URLSession.shared
let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!

struct Post: Codable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}

var cancellables: Set<AnyCancellable> = []

struct TemporaryIssue: Error { }

var simulatedErrors = 3

func fetchPost() -> AnyPublisher<Post, Error> {
    session.dataTaskPublisher(for: url)
        .tryMap {
            if simulatedErrors > 0 {
                simulatedErrors -= 1
                throw TemporaryIssue()
            }
            return $0.data
        }
        .decode(type: Post.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
}

let publisher = fetchPost()

publisher
    .print()
    .retry(3)
    .sink { print($0) } receiveValue: { print($0) }
    .store(in: &cancellables)

