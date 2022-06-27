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
    
    merged.sink { print($0) }
}
