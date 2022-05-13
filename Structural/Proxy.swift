// MARK: - Proxy
import Foundation

protocol Subject {
    func operation()
}

class RealSubject: Subject {
    func operation() { print("RealSubject operation") }
}

class ProxyLogger: Subject {
    private let subject: RealSubject
    init(subject: RealSubject) { self.subject = subject }
    func operation() {
        logStart()
        subject.operation()
        logEnd()
    }
    private func logStart(){
        print("\nREQUEST SEND 🕑\nTime - \(Date())")
    }
    private func logEnd() {
        print("\nREQUEST END ✅\nTime - \(Date())\n")
    }
}

class Client {
    static func perform(subject: Subject) {
        subject.operation()
    }
}

class App {
    func main() {
        let subject = RealSubject()
        Client.perform(subject: subject)

        let proxyLogger = ProxyLogger(subject: subject)
        Client.perform(subject: proxyLogger)
    }
}

let app = App()
app.main()

/*
 Output:
 RealSubject operation

 REQUEST SEND 🕑
 Time - 2022-05-13 07:23:37 +0000
 RealSubject operation

 REQUEST END ✅
 Time - 2022-05-13 07:23:37 +0000
 */
