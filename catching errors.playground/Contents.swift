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
/*
 catch block returns a Publisher, in this case it is a Just Publisher.
 we have to tell the compiler return type, otherwise it can not infer the return value, because there is a print statement.
 */
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
subject2.send(2)

let publisher3 = [4, 2, 5, 1, 5, 2, 1].publisher

let pub4 = publisher3.tryMap { value -> Int in
    if value < 2 {
        throw DummyError()
    } else {
        return value
    }
}

pub4
    .replaceError(with: -1)
    .sink { print("value \($0)") }

