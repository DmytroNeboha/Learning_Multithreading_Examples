import UIKit
import PlaygroundSupport


PlaygroundPage.current.needsIndefiniteExecution = true



let queue = DispatchQueue(label: "The Swift Developer", attributes: .concurrent)

//let semaphor = DispatchSemaphore(value: 2)
//
//
//queue.async {
//    semaphor.wait() // -1
//    sleep(3)
//    print("method 1")
//    semaphor.signal() // +1
//}
//
//queue.async {
//    semaphor.wait() // -1
//    sleep(3)
//    print("method 2")
//    semaphor.signal() // +1
//}
//
//queue.async {
//    semaphor.wait() // -1
//    sleep(3)
//    print("method 3")
//    semaphor.signal() // +1
//}


//let sem = DispatchSemaphore(value: 2)
//
//DispatchQueue.concurrentPerform(iterations: 10) { (id: Int) in
//    sem.wait(timeout: DispatchTime.distantFuture)
//    sleep(1)
//    print("Block", String(id))
//
//    sem.signal() //
//}


class SemaphorTest {
    private let semaphore = DispatchSemaphore(value: 2)
    private var array = [Int]()
    
    private func methodWork(_ id: Int) {
        semaphore.wait() // -1
        
        array.append(id)
        print("test array", array.count)
        
        Thread.sleep(forTimeInterval: 1)
        semaphore.signal() // +1
    }
    
    public func startAllThread() {
        DispatchQueue.global().async {
            self.methodWork(111)
        }
        DispatchQueue.global().async {
            self.methodWork(324)
        }
        DispatchQueue.global().async {
            self.methodWork(2555)
        }
        DispatchQueue.global().async {
            self.methodWork(121113444)
        }
    }
}

let semaphorTest = SemaphorTest()
semaphorTest.startAllThread()
