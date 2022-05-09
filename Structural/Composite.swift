// MARK: - Composite

protocol Component {
    var parent: Component? { get set }
    func add(_ component: Component)
    func remove(_ component: Component)
    func clientOperation() -> String
}

extension Component {
    func add(_ component: Component) { }
    func remove(_ component: Component) { }
}

class Leaf: Component {
    var parent: Component?
    func clientOperation() -> String {
        return "Leaf"
    }
}

class Composite: Component {
    var parent: Component?
    private var children: [Component] = []

    func add(_ component: Component) {
        var item = component
        item.parent = self
        children.append(item)
    }
    func clientOperation() -> String {
        let result = children.map { $0.clientOperation() }
        return "Branch(" + result.joined(separator: " ") + ")"
    }
    func remove(_ component: Component) { }
}

class Client {
    static func someClientCode(component: Component) {
        print("Result - \(component.clientOperation())")
    }
}

class App {
    func main() {
        Client.someClientCode(component: Leaf())

        let tree = Composite()
        let branch1 = Composite()
        branch1.add(Leaf())
        branch1.add(Leaf())
        branch1.add(Leaf())

        let branch2 = Composite()
        branch2.add(Leaf())

        let branch3 = Composite()
        branch3.add(Leaf())
        branch3.add(Leaf())

        tree.add(branch1)
        tree.add(branch2)
        tree.add(branch3)

        Client.someClientCode(component: tree)
    }
}

let app = App()
app.main()

/*
 Output:
 Result - Leaf
 Result - Branch(Branch(Leaf Leaf Leaf) Branch(Leaf) Branch(Leaf Leaf))
 */
