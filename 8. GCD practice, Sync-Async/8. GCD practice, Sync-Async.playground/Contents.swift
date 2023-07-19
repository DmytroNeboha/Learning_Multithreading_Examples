import UIKit
import PlaygroundSupport


/* Никогда НЕ вызывайте метод sync на main queue, потому что это приведет к взаимной
блокировке (вуфвдщсл) вашего приложения! */


class MyViewController: UIViewController {
    
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "vc 1"
        
        self.view.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(pressAction), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        initButton()
    }
    
    @objc func pressAction() {
        let vc = TwoMyViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func initButton() {
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
        button.setTitle("Press", for: .normal)
        button.backgroundColor = UIColor.green
        button.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(button)
    }
}


class TwoMyViewController: UIViewController {
    
    var image = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "vc 2"
        
        self.view.backgroundColor = UIColor.white
        
//        //реалізація сповільнить відкриття нашого контролера, відкриється після завантаження фото. Тобто цим ми блокуємо main потік
//        let imageURL: URL = URL(string: "https://www.planetware.com/wpimages/2023/02/south-africa-mossel-bay-top-rated-things-to-do-intro-paragraph-diaz-beach-surfers.jpg")!
//        if let data = try? Data(contentsOf: imageURL) {
//            self.image.image = UIImage(data: data)
//        }
        
        loadPhoto()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        initImage()
    }
    
    func initImage() {
        image.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        image.center = view.center
        view.addSubview(image)
    }
    
    func loadPhoto() {
        let imageURL: URL = URL(string: "https://www.planetware.com/wpimages/2023/02/south-africa-mossel-bay-top-rated-things-to-do-intro-paragraph-diaz-beach-surfers.jpg")!
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
            }
        }
    }
}
 


let vc = MyViewController()
let navbar = UINavigationController(rootViewController: vc)

PlaygroundPage.current.liveView = navbar



