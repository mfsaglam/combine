import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class TickTock {
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        Timer.publish(every: 0.5, on: .main, in: .common)
        /*
         Timer is a connectable publisher.
         - We provide interval, runLoop and runLoop mode. for more info: https://developer.apple.com/documentation/foundation/runloop/mode
         - connectable publishers doesn't start doing any work until we call connect().
         - to allow it start as soon as you subscribe, use autoconnect()
         */
            .autoconnect()
            .print("Timer")
            .sink { [weak self] _ in
                /*we add a sink subscriber which prints out a message.
                 - Sink returns an AnyCancellable instance. we store that as a property in our cancellables set.
                 */
                self?.tick()
            }
            .store(in: &cancellables)
    }
    
    func tick() {
        print("Tick")
    }
}


