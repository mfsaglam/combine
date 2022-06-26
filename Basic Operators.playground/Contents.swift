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

example("Scan") {
    let grades: [Double] = [98, 65, 49, 99, 100, 95]
    _ = grades.publisher
        .scan((avg: 0.0, sum: 0.0, count: 0.0)) { tuple, grade in
            let newSum = tuple.sum + grade
            let count = tuple.count + 1
            let avg = newSum / Double(count)
            return(avg: avg, sum: newSum, count: count)
        }
        .map { $0.avg }
        .sink { print($0) }
}

example("Remove Duplicates") {
    [1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 1, 1, 2, 2,].publisher
        .removeDuplicates()
        .sink { print($0) }
}

example("Compact Map") {
    let values: [Int?] = [1, nil, 2, nil, 3]
    _ = values.publisher
        .compactMap { $0 }
        .sink { print($0) }
    
    ["a", "12", "asd", "1", "22"].publisher
        .compactMap{ Int($0) }
        .sink { print($0) }
}
