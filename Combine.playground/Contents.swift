import UIKit
import Combine

class SDemo{
    
    @Published var value: Int = 0
    var valueSubscriber: AnyCancellable?
    
    var gotValue: Int = 0{
        didSet{
            print(gotValue)
        }
    }
    
    init() {
        valueSubscriber = $value.receive(on: DispatchQueue.main).assign(to: \.gotValue, on: self)
        
    }
    
    
}


let s = SDemo()
s.value = 10

//let wetherPublisher = PassthroughSubject<Int,Never>()
//let publisher2 = wetherPublisher
//
//let subscriber = wetherPublisher.filter({$0 > 25}).sink { value in
//    print(value)
//}
//
//publisher2.send(20)
//publisher2.send(28)
//publisher2.send(15)
//publisher2.send(825)


