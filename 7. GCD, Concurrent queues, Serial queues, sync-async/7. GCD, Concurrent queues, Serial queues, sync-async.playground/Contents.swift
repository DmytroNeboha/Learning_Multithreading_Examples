import UIKit



// Queue - ми керуємо чергами, НЕ потоками. Потоками керує iOS


class QueueTest1 {
    private let serialQueue = DispatchQueue(label: "serialTest")
    private let concurrentQueue = DispatchQueue(label: "concurrentTest", attributes: .concurrent)
}

class QueueTest2 {
    private let globalQueue = DispatchQueue.global()
    private let mainQueue = DispatchQueue.main
    
}
