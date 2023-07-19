import UIKit
import PlaygroundSupport

// щоб дочекатись завантаження всих потоків
PlaygroundPage.current.needsIndefiniteExecution = true



class DispatchWorkItem1 {
    private let queue = DispatchQueue(label: "DispatchWorkItem1", attributes: .concurrent)
    
    func create() {
        let workItem = DispatchWorkItem {
            print(Thread.current)
            print("start task")
        }
        
        workItem.notify(queue: .main) {
            print(Thread.current)
            print("Task finish")
        }
        queue.async(execute: workItem)
    }
}

let dispatchWorkItem1 = DispatchWorkItem1()
//dispatchWorkItem1.create()


class DispatchWorkItem2 {
    private let queue = DispatchQueue(label: "DispatchWorkItem1")
    
    func create() {
        queue.async {
            sleep(1)
            print(Thread.current)
            print("task 1")
        }
        
        queue.async {
            sleep(1)
            print(Thread.current)
            print("task 2")
        }
        
        let workItem = DispatchWorkItem {
            print(Thread.current)
            print("Strat work item task")
        }
        
        queue.async(execute: workItem)
        
        workItem.cancel()
    }
}
//let dispatchWorkItem2 = DispatchWorkItem2()
//dispatchWorkItem2.create()



var view = UIView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))
var stateImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))

stateImage.backgroundColor = UIColor.red
stateImage.contentMode = .scaleAspectFit
view.addSubview(stateImage)

PlaygroundPage.current.liveView = view

let imageURL = URL(string: "https://www.planetware.com/photos-large/USNY/new-york-city-statue-of-liberty.jpg")!


// # classic
func fetchImage() {
    let queue = DispatchQueue.global(qos: .utility)
    
    queue.async {
        if let data = try? Data (contentsOf: imageURL) {
            DispatchQueue.main.async {
                stateImage.image = UIImage(data: data)
            }
        }
    }
}
//fetchImage()


// # Dispatch work item
func fetchImage2() {
    var data: Data?
    let queue = DispatchQueue.global(qos: .utility)
    
    let workItem = DispatchWorkItem(qos: .userInteractive) {
        data = try? Data(contentsOf: imageURL)
        print(Thread.current)
    }
    queue.async(execute: workItem)
    
    workItem.notify(queue: DispatchQueue.main) {
        if let imageData = data {
            stateImage.image = UIImage(data: imageData)
        }
    }
}
//fetchImage2()


// # URLSession
func fetchImage3() {
    let task = URLSession.shared.dataTask(with: imageURL) { data, URLResponse, error in
        print(Thread.current)
        if let imageData = data {
            DispatchQueue.main.async {
                stateImage.image = UIImage(data: imageData)
            }
        }
    }
    task.resume()
}
fetchImage3()


