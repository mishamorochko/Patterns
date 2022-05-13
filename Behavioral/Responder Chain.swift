// MARK: - Responder Chain

protocol Handler: AnyObject {
    func setNext(handler: Handler) -> Handler
    func handle(request: String) -> String?
    var nextHandler: Handler? { get set }
}

extension Handler {
    func setNext(handler: Handler) -> Handler {
        nextHandler = handler
        return handler
    }
    func handle(request: String) -> String? {
        nextHandler?.handle(request: request)
    }
}

class Handler1: Handler {
    var nextHandler: Handler?

    func handle(request: String) -> String? {
        if request == "handler1 request." {
            return "HANDLER 1 processed. \(request)"
        } else {
            return nextHandler?.handle(request: request)
        }
    }
}

class Handler2: Handler {
    var nextHandler: Handler?

    func handle(request: String) -> String? {
        if request == "handler2 request." {
            return "HANDLER 2 processed. \(request)"
        } else {
            return nextHandler?.handle(request: request)
        }
    }
}

class Handler3: Handler {
    var nextHandler: Handler?
    func handle(request: String) -> String? {
        if request == "handler3 request." {
            return "HANDLER 3 processed. \(request)"
        } else {
            return nextHandler?.handle(request: request)
        }
    }
}

class Client {
    static func someClientCode(handle: Handler) {
        let requests = ["handler2 request.", "handler1 request.", "handler3 request."]
        for request in requests {
            guard let result = handle.handle(request: request) else { return }
            print(result)
        }
    }
}

class App {
    func main() {
        let handler1 = Handler1()
        let handler2 = Handler2()
        let handler3 = Handler3()
        handler1.setNext(handler: handler2).setNext(handler: handler3)
        Client.someClientCode(handle: handler1)
    }
}

let app = App()
app.main()

/*
 Output:
 HANDLER 2 processed. handler2 request.
 HANDLER 1 processed. handler1 request.
 HANDLER 3 processed. handler3 request.
 */
