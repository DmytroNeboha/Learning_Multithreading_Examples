import UIKit




var available = false
var condition = pthread_cond_t()
var mutex = pthread_mutex_t()


class ConditionMutexPrinter: Thread {
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        printerMethod()
    }
    
    private func printerMethod() {
        pthread_mutex_lock(&mutex)
        print("Printer enter")
        while (!available) {
            pthread_cond_wait(&condition, &mutex)
        }
        available = false
        defer {
            pthread_mutex_unlock(&mutex)
        }
        print("Printer exit")
    }
}



class ConditionMutexWriter: Thread {
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        writerMethod()
    }
    
    private func writerMethod() {
        pthread_mutex_lock(&mutex)
        print("Writer enter")
        available = true
        pthread_cond_signal(&condition)
        defer {
            pthread_mutex_unlock(&mutex)
        }
        print("Writer exit")
    }
}


let conditionMutexPrinter = ConditionMutexPrinter()
let conditionMutexWriter = ConditionMutexWriter()

//conditionMutexPrinter.start()
//conditionMutexWriter.start()


let condi = NSCondition()
var availables = false


class WriterThread: Thread {
    
    override func main() {
        condi.lock()
        print("WriteThread enter")
        availables = true
        condi.signal()
        condi.unlock()
        print("WriterThread exit")
    }
}

class PrinterThread: Thread {
    
    override func main() {
        condi.lock()
        print("PrintedThread enter")
        while (!availables) {
            condi.wait()
        }
        availables = false
        condi.unlock()
        print("PrintedThread exit")
    }
}

let writer = WriterThread()
let printer = PrinterThread()
printer.start()
writer.start()
