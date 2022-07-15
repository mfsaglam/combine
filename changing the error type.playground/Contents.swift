import Foundation
import Combine

/*
 Sometimes we want to combine 2 publishers together such as CombineLatest, that needs us to match the output and error types.
 That case we need to set a failure type.
*/

let publisher = [1, 2, 3].publisher
    .setFailureType(to: Error.self)
let subject = PassthroughSubject<Int, Error>()

enum FriendlyErrors: Error {
    case unableToConnect
    case other(URLError)
}

let networkPublisher = PassthroughSubject<String, URLError>()

let pub = networkPublisher
    .mapError { error -> FriendlyErrors in
        switch error {
        case URLError.badURL,
            URLError.cannotConnectToHost,
            URLError.notConnectedToInternet,
            URLError.networkConnectionLost:
            return FriendlyErrors.unableToConnect
        default:
            return FriendlyErrors.other(error)
        }
    }

print (type(of: pub).Output)
print (type(of: pub).Failure)

let pub2 = networkPublisher.assertNoFailure()

print(type(of: pub2).Failure)
