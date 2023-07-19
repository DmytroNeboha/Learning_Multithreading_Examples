import UIKit


// Thread
// Operation
// GCD

// 1Паралель -----------
// 2Thread   ----------

// ------- Последовательные ---
// 1Thread   - ---
// 2Thread -- -   --


// ------асинхронный ----
// 1Main(UI) ------------
// 2Thread         -



// Unix - POSIX

var thread = pthread_t(bitPattern: 0) // создаём поток
var attribut = pthread_attr_t() // создаём атрибут

pthread_attr_init(&attribut)
pthread_create(&thread, &attribut, { (pointer) -> UnsafeMutableRawPointer? in
    print("test")
    return nil
}, nil)

// 2 Thread
var nsthread = Thread {
    print("test")
}

nsthread.start()
nsthread.isFinished
Thread.setThreadPriority(2)
nsthread.cancel()


