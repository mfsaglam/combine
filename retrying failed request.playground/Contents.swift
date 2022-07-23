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

extension Publisher where Output == (data: Data, response: URLResponse) {
    func assumeHTTP() -> AnyPublisher<(data: Data, response: HTTPURLResponse), HTTPError> {
        tryMap { (data: Data, response: URLResponse) -> (Data, HTTPURLResponse) in
            guard let http = response as? HTTPURLResponse else {
                throw HTTPError.nonHTTPResponse
            }
            return (data, http)
        }
        .mapError { error in
            if error is HTTPError {
                return error as! HTTPError
            } else {
                return HTTPError.networkError(error)
            }
        }
        .eraseToAnyPublisher()
    }
}

func fetchPost() -> AnyPublisher<Post, HTTPError> {
    session.dataTaskPublisher(for: url)
        .assumeHTTP()
        .tryMap {
            if simulatedErrors > 0 {
                simulatedErrors -= 1
                throw TemporaryIssue()
            }
            return $0.data
        }
        .decode(type: Post.self, decoder: JSONDecoder())
        .mapError { error in
            if error is HTTPError {
                return error as! HTTPError
            } else {
                return HTTPError.networkError(error)
            }
        }
        .eraseToAnyPublisher()
}

let publisher = fetchPost()

enum HTTPError: Error {
    case nonHTTPResponse
    case requestFailed(Int)
    case serverError(Int)
    case networkError(Error)
    case decodingError(DecodingError)
    
    var isRetriable: Bool {
        switch self {
        case .nonHTTPResponse, .networkError(_), .serverError(_):
            return true
        case .requestFailed(let status):
            let timeOutStatus = 408
            let rateLimitStatus = 428
            return [timeOutStatus, rateLimitStatus].contains(status)
        case .decodingError(_):
            return false
        }
    }
}

publisher
    .print()
    .retry(3)
    .sink { print($0) } receiveValue: { print($0) }
    .store(in: &cancellables)

