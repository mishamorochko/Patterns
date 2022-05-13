// MARK: - Command

protocol Command {
    func operation()
}

class SimpleCommand1: Command {
    func operation() {
        print("SimpleCommand1 -> operation.")
    }
}

class SimpleCommand2: Command {
    func operation() {
        print("SimpleCommand2 -> operation.")
    }
}

class Receiver {
    func operationA(context: String) {
        print("Receiver -> operationA \(context).")
    }
    func operationB(context: String) {
        print("Receiver -> operationB \(context).")
    }
}

class ComplexCommand: Command {

    private let receiver: Receiver

    private let contextA: String
    private let contextB: String

    init(receiver: Receiver, contextA: String, contextB: String) {
        self.receiver = receiver
        self.contextA = contextA
        self.contextB = contextB
    }

    func operation() {
        receiver.operationA(context: contextA)
        receiver.operationB(context: contextB)
    }
}

class Invoker {
    private var commands = [Command]()

    func addCommandToExecute(_ command: Command) {
        commands.append(command)
    }

    func clientCode() {
        commands.forEach { $0.operation() }
    }
}

class App {
    func main() {
        let invoker = Invoker()
        invoker.addCommandToExecute(SimpleCommand1())
        invoker.addCommandToExecute(SimpleCommand2())

        let receiver = Receiver()
        invoker.addCommandToExecute(ComplexCommand(receiver: receiver, contextA: "context A", contextB: "context B"))
        invoker.clientCode()
    }
}

let app = App()
app.main()

/*
 Output:
 SimpleCommand1 -> operation.
 SimpleCommand2 -> operation.
 Receiver -> operationA context A.
 Receiver -> operationB context B.
 */
