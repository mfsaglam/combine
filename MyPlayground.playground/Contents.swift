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

///Most of the time we will chain things together like below example:

func sinkExampleShorthand() {
    let publisher = [1, 3, 5, 8, 11].publisher
    publisher.sink { completion in
        print(completion)
    } receiveValue: { value in
        print(value)
    }

}

sinkExampleShorthand()
