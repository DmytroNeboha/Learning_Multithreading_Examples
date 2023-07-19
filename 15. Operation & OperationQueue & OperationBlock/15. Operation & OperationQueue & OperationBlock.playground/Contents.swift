import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


//print(Thread.current)

//let operation1 = {
//    print("Start")
//    print(Thread.current)
//    print("Finish")
//}
//
//let queue = OperationQueue()
//queue.addOperation(operation1)


//print(Thread.current)
//
//var result: String?
//let concatOperation = BlockOperation {
//    result = "The Swift" + " " + "Developers"
//    print(Thread.current)
//}
//
////concatOperation.start()
////
////print(result!)
//
//let queue = OperationQueue()
//queue.addOperation(concatOperation)
//sleep(2)
//print(result ?? "Not defined")

//print(Thread.current)

//let queue1 = OperationQueue()
//queue1.addOperation {
//    print("test")
//    print(Thread.current)
//}

//print(Thread.current)
//
//class MyThread: Thread {
//    override func main() {
//        print("Test main thred")
//    }
//}
//
//let myThread = MyThread()
//myThread.start()

print(Thread.current)

class OperationA: Operation {
    override func main() {
        print("Test operation A")
        print(Thread.current)
    }
}

let operationA = OperationA()
//operationA.start()

let queue1 = OperationQueue()
queue1.addOperation(operationA)
   
