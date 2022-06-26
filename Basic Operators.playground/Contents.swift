import Combine

func example(_ title: String, _ block: () -> Void ) {
    print("\n----------[\(title)]----------")
    block()
    print("----------------------------\n\n")
}

example("Map") {
    _ = [1, 2, 3, 5, 8, 13].publisher
        .map { $0 * 10 }
        .sink { print ($0) }
}

example("Filter") {
    _ = [1, 2, 3, 5, 8, 13].publisher
        .map { $0 * 10 }
        .filter { $0 < 60 }
        .sink { print ($0) }
}
