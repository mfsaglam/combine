import Foundation
import Combine

struct DummyError: Error { }

let subject = PassthroughSubject<Int, DummyError>()

subject.sink { completion in
    print("completion: \(completion)")
} receiveValue: { value in
    print("value: \(value)")
}

subject.send(1)
subject.send(completion: .failure(DummyError()))
subject.send(2)

