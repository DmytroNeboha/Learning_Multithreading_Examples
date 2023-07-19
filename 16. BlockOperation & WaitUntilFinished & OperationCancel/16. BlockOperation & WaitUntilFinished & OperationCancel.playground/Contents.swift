import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let operationQueue = OperationQueue()

class OperationCacelTest: Operation {
    override func main() {
        if isCancelled {
            print(isCancelled)
            return
        }
        print("test 1")
        sleep(1)
        
        if isCancelled {
            print(isCancelled)
            return
        }
        print("test 2")
    }
}

func cancelOperationMethod() {
    let cancelOperation = OperationCacelTest()
    operationQueue.addOperation(cancelOperation)
    cancelOperation.cancel()
}

//cancelOperationMethod()


class WaitOperatonTest {
    private let operationQueue = OperationQueue()
    
    func test() {
        operationQueue.addOperation {
            sleep(1)
            print("test 1")
        }
        
        operationQueue.addOperation {
            sleep(2)
            print("test 2")
        }
        // барьер
        operationQueue.waitUntilAllOperationsAreFinished()
        operationQueue.addOperation {
            sleep(1)
            print("test 3")
        }
        
        operationQueue.addOperation {
            sleep(1)
            print("test 4")
        }
    }
}

let waitOperationTest = WaitOperatonTest()
//waitOperationTest.test()


class WaitOperationTest2 {
    private let operationQueue = OperationQueue()
    
    func test() {
        let operation1 = BlockOperation {
             sleep(1)
            print("test 1")
        }
        let operation2 = BlockOperation {
             sleep(2)
            print("test 2")
        }
        
        // добавляем барьер через через массив
        operationQueue.addOperations([operation1,operation2], waitUntilFinished: true)
    }
}

let waitOperationTest2 = WaitOperationTest2()
//waitOperationTest2.test()


class CompletionBlockTest {
    private  let operationQueue = OperationQueue()
    
    func test() {
        let operation1 = BlockOperation {
            sleep(3)
            print("test CompletionBlock")
        }
        operation1.completionBlock = {
            print("finish completionBlock")
        }
        operationQueue.addOperation(operation1)
    }
}

let completionBlockTest = CompletionBlockTest()
completionBlockTest.test()
