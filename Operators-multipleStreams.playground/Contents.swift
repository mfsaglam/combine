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
