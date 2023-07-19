import UIKit



// NSRecursiveLock & Mutex Recursive lock 4



//MARK: Проблемы потоков


/*
 
 - Условия гонки [Race condition] - С несколькими потоками,
 при работе с одними данными, в результате чего сами данные
 становятся непредсказуемыми и зависят от порядка выполнения потоков.
 
 - Конкуренция за ресурс [Resource contention] - Несколько потоков, выполняющих
 разные задачи, пытаются получить доступ к одному рессурсу, тем самым увеличивая
 время необходимое для безопасного получения ресурся. Эта задержка может
 привести к непредвиденному поведению.
 
 - Вечная блокировка [Deadlock] - Несколько потоков блокируют друг друга
 
 - Голодание [Starvation] - Поток не может получить доступ к ресурсу и безуспешно пытается
 это снова и снова.
 
 - Инверсия приоритетов [Priority Inversion] - Поток с низким приоритетом удерживает ресурс, которые
 требуется другому потоку с более высоким приоритетом.
 
 - Неопределенность и справедливость [Non-deterministic and Fairness] - Мы не можем делать предположений, когда и
 в каком порядке поток сможет получить ресурс, эта задержка не может быть определена
 априории и в значительной степени зависит от количества конфликтов. Однако примитивы
 синхронизации могут обеспечивать справедливость, гарантируя доступ всем потокам
 которые ожидают, также учитывая порядок.
 
*/
 


// C

// один поток отдельно от Main
class RecursiveMutexTest {
    private var mutex = pthread_mutex_t()
    private var attribute = pthread_mutexattr_t()
    
    init() {
        pthread_mutexattr_init(&attribute)
        pthread_mutexattr_settype(&attribute, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&mutex, &attribute)
    }
    
    func firstTask() {
        pthread_mutex_lock(&mutex)
        twoTask()
        defer {
            pthread_mutex_unlock(&mutex)
        }
    }
    
    func twoTask() {
        pthread_mutex_lock(&mutex)
        print("Finish")
        defer {
            pthread_mutex_unlock(&mutex)
        }
    }
}


let recursive = RecursiveMutexTest()
recursive.firstTask()



// Objective-C оболочка


let recursiveLock = NSRecursiveLock()

class RecursiveThread: Thread {
    
    override func main() {
        recursiveLock.lock()
        print("Thread acquired lock")
        callMe()
        defer {
            recursiveLock.unlock()
        }
        print("Exit main")
    }
    
    func callMe() {
        recursiveLock.lock()
        print("Thread acquired lock")
        defer {
            recursiveLock.unlock()
        }
        print("Exit callMe")
    }
}

let thread = RecursiveThread()
thread.start()
