import Foundation
import Combine

///SUBJECTS

//PassthroughSubject

let subject = PassthroughSubject<String, Never>()
subject.sink { print("1) received \($0)") }

subject.send("Message 1")
subject.send("Message 2")

print("------------")

let subject2 = PassthroughSubject<String, Never>()
subject2.sink { completion in
    print(completion)
} receiveValue: { value in
    print(value)
}

subject2.send("2) Testing completion...")
subject2.send(completion: .finished)

print("------------")

struct CustomError: Error { }

let subject3 = PassthroughSubject<String, CustomError>()
subject3.sink { completion in
    print(completion)
} receiveValue: { value in
    print(value)
}

subject3.send("3) Testing completion...")
subject3.send(completion: .failure(CustomError()))



//CurrentValueSubject




