import UIKit

/// C
//class SaveThread {
//    private var mutex = pthread_mutex_t()
//
//    init() {
//        pthread_mutex_init(&mutex, nil)
//    }
//
//    func someMethod(completion: () -> ()) {
//        pthread_mutex_lock(&mutex)
//        completion()
//        defer {
//            pthread_mutex_unlock(&mutex)
//        }
//    }
//}



// оболочка Objective-C
class SaveThread {
    private let lockMutex = NSLock()
    
    func someMethod(completion: () -> ()) {
        lockMutex.lock()
        
        completion()
        defer {
            lockMutex.unlock()
        }
    }
}


var array = [String]()
let saveThread = SaveThread()

// теперь массив потокозащищенный
saveThread.someMethod {
    print("test")
    array.append("1 thread")
}

array.append("2 thread")
