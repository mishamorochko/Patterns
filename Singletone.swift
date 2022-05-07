// Singletone
import Foundation

class NotificationService {
    static let instance = NotificationService()
    private init() { }
    func createNotification(name: String) { }
    func deleteNotification(name: String) { }
}

extension NotificationService: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}

class App {
    func main() {
        let instance1 = NotificationService.instance
        let instance2 = NotificationService.instance

        if instance1 === instance2 {
            print("OK. Same instance here.")
        } else {
            print("Failed. different instance here.")
        }
    }
}

let app = App()
app.main()
