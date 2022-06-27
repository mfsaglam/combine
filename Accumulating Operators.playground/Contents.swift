import Combine

func example(_ title: String, _ block: () -> Void ) {
    print("\n----------[\(title)]----------")
    block()
    print("----------------------------\n\n")
}

example("Reduce") {
    let values = [1, 5, 12]
    values.publisher
        .print()
        .reduce(0) { sum, value in
            sum + value
        }
        .sink { print($0) }
}

example("Count") {
    let values = [1, 5, 12]
    values.publisher
        .print()
        .count()
        .sink { print($0) }
}
