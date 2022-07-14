import Foundation
import Combine

struct DivideByZeroError: Error { }

let denominators = [4, 3, 2, 7, 0].publisher

denominators
    .tryMap { value -> Double in
        guard value != 0 else { throw DivideByZeroError() }
        return 10.0 / Double(value)
    }
    .sink { completion in
        print(completion)
    } receiveValue: { value in
        print(value)
    }


