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

let subject2 = PassthroughSubject<Int, DummyError>()

subject2
    .catch { error -> Just<Int> in
        print("error \(error)")
        return Just(-1)
    }.sink { completion in
        print("completion: \(completion)")
    } receiveValue: { value in
        print("value: \(value)")
    }

subject2.send(1)
subject2.send(completion: .failure(DummyError()))

