import Foundation
import Combine

///SUBJECTS

//PassthroughSubject

let subject = PassthroughSubject<String, Never>()
subject.sink { print("1) received \($0)") }

subject.send("Message 1")
subject.send("Message 2")


//CurrentValueSubject




