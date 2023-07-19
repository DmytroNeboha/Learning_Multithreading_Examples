

import UIKit

class TwoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        for i in 0...200000 {
//            print(i)
//        }
        
        
//        DispatchQueue.concurrentPerform(iterations: 200000) {
//            print("\($0) times")
//            print(Thread.current)
//        }
        
        
//        let queue = DispatchQueue.global(qos: .utility)
//        queue.async {
//            DispatchQueue.concurrentPerform(iterations: 200000) {
//                        print("\($0) times")
//                        print(Thread.current)
//            }
        
        myInactiveQueue()
        
        }
        
        func myInactiveQueue() {
            let inactiveQueue = DispatchQueue(label: "The Swift Dev", attributes: [.concurrent, .initiallyInactive])
            
            inactiveQueue.async {
                print("Done!")
            }
            print("not yet startet...")
            inactiveQueue.activate()
            print("Activate!")
            inactiveQueue.suspend()
            print("Pause!")
            inactiveQueue.resume()
        }
    }


