import Combine

/**
Subscribers

Sink
Assign
 
**/

func sinkExampleManual() {
    let publisher = [1, 3, 5, 8, 11].publisher
    
    let subscriber = Subscribers.Sink<Int, Never> { completion in
        print(completion)
    } receiveValue: { value in
        print(value)
    }
    
    publisher.subscribe(subscriber)
    
}

sinkExampleManual()
