import Foundation
import Combine

class Car {
    @Published private(set) var gasLevel = 1.0
    
    func drive() {
        if gasLevel > 0 {
            print("🚗💨")
            gasLevel -= 0.25
        } else {
            print("🔴 OUT OF GAS")
        }
    }
}

let car = Car()
car.$gasLevel
    .drop(while: { $0 > 0.4 })
    .sink { print("WARNING❗️ LOW ON GAS \($0)") }

car.drive()
car.drive()
car.drive()
car.drive()
car.drive()

