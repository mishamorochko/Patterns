// MARK: - Facade

class System1 {
    func operation1() -> String {
        return "System 1. Operation 1.\n"
    }

    func operation2() -> String {
        return "System 1. Operation 2.\n"
    }
}

class System2 {
    func operation1() -> String {
        return "System 2. Operation 1.\n"
    }

    func operation2() -> String {
        return "System 2. Operation 2.\n"
    }
}

class Facade {

    private var system1: System1
    private var system2: System2

    init(system1: System1 = System1(), system2: System2 = System2()) {
        self.system1 = system1
        self.system2 = system2
    }

    func operation() -> String {
        var result = ""
        result += system1.operation1()
        result += system2.operation1()
        result += system1.operation2()
        result += system2.operation2()
        return result
    }
}

class Client {
    static func callSystemsOperations(facade: Facade) {
        print(facade.operation())
    }
}

class App {
    func main() {
        let system1 = System1()
        let system2 = System2()
        let facade = Facade(system1: system1, system2: system2)
        Client.callSystemsOperations(facade: facade)
    }
}

let app = App()
app.main()

/*
 Output:
 System 1. Operation 1.
 System 2. Operation 1.
 System 1. Operation 2.
 System 2. Operation 2.
 */

// Facade without facade object
import UIKit
extension UIImageView {
    func download(from url: URL?) {
        let placeholder = UIImage()
        image = placeholder
        ImageDownloader().loadImage(from: url) { image in
            self.image = image
        }
    }
}

class ImageDownloader {
    func loadImage(from url: URL?, completion: ((UIImage) -> Void)) {
        // load image from url using network layer
        completion(UIImage())
    }
}
