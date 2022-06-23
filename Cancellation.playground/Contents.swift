import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class TickTock {
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        Timer.publish(every: 0.5, on: .main, in: .common)
            .autoconnect()
            .print("Timer")
            .sink { [weak self] _ in
                self?.tick()
            }
            .store(in: &cancellables)
    }
    
    func tick() {
        print("Tick")
    }
}


