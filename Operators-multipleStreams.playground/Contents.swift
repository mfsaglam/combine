import Combine

func example(_ title: String, _ block: () -> Void ) {
    print("\n----------[\(title)]----------")
    block()
    print("----------------------------\n\n")
}

example("merge") {
    let pub1 = CurrentValueSubject<Int, Never>(100)
    let pub2 = [1, 2, 3].publisher
    
    let merged = pub1.merge(with: pub2)
        .print()
    merged.sink { print($0) }
    
    pub1.send(200)
    pub1.send(completion: .finished)
}

example("merge multiple") {
    let pub1 = [1, 2, 3].publisher
    let pub2 = [4, 5, 6].publisher
    let pub3 = [7, 8, 9].publisher
    
    Publishers.MergeMany([pub1, pub2, pub3])
        .sink{ print($0) }
}

example("zip") {
    let ints = [1, 2, 3].publisher
    let letters = ["a", "b", "c", "d"].publisher
    
    ints.zip(letters)
        .map {"\($0.0) -> \($0.1)"}
        .sink{ print($0) }
}

example("Combine Latest") {
    let pub1 = CurrentValueSubject<Bool, Never>(false)
    let pub2 = CurrentValueSubject<Bool, Never>(false)
    let pub3 = CurrentValueSubject<Bool, Never>(false)
    
    pub1.send(true)
    
    pub1.combineLatest(pub2, pub3)
        .print("CL")
        .map { switches in
            switches.0 && switches.1 && switches.2
        }
        .filter { $0 }
        .sink { print($0) }
    
    pub2.send(true)
    pub3.send(true)
}
