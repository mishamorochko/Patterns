// MARK: - Mediator

protocol Mediator: AnyObject {
    func notify(sender: BaseComponent, event: String)
}

class ConcreteMediator: Mediator {
    private var component1: Component1
    private var component2: Component2
    init(_ component1: Component1, _ component2: Component2) {
        self.component1 = component1
        self.component2 = component2

        component1.update(mediator: self)
        component2.update(mediator: self)
    }
    func notify(sender: BaseComponent, event: String) {
        if event == "A" {
            print("Mediator handle event and send command to component2")
            component2.operationC()
        } else if event == "D" {
            print("Mediator handle event and send command to component1")
            component1.operationB()
            component2.operationC()
        }
    }
}

class BaseComponent {
    weak var mediator: Mediator?
    init(mediator: Mediator? = nil) { self.mediator = mediator }
    func update(mediator: Mediator) { self.mediator = mediator }
}

class Component1: BaseComponent {
    func operationA() {
        print("Component1 does operation A.")
        mediator?.notify(sender: self, event: "A")
    }

    func operationB() {
        print("Component1 does operation B.")
        mediator?.notify(sender: self, event: "B")
    }
}

class Component2: BaseComponent {
    func operationC() {
        print("Component2 does operation C.")
        mediator?.notify(sender: self, event: "C")
    }
    func operationD() {
        print("Component2 does operation D.")
        mediator?.notify(sender: self, event: "D")
    }
}

class App {
    func main() {
        let component1 = Component1()
        let component2 = Component2()

        let mediator = ConcreteMediator(component1, component2)

        component2.operationD()
        print("")
        component1.operationA()
    }
}

let app = App()
app.main()

/*
 Output:
 Component2 does operation D.
 Mediator handle event and send command to component1
 Component1 does operation B.
 Component2 does operation C.

 Component1 does operation A.
 Mediator handle event and send command to component2
 Component2 does operation C.
 */

