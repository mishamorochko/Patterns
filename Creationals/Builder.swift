// MARK: - Builder

protocol PizzaBuilder {
    func createMain()
    func addCheese()
    func addSause()
    func addChicken()
}

final class BasicPizzaBuilder: PizzaBuilder {

    private var pizza = BasicPizza()

    func reset() {
        pizza = BasicPizza()
    }

    func createMain() {
        pizza.add("Main")
    }

    func addCheese() {
        pizza.add("Cheese")
    }

    func addSause() {
        pizza.add("Sause")
    }

    func addChicken() {
        pizza.add("Chicken")
    }

    func getPizza() -> BasicPizza {
        return pizza
    }
}

final class MegaPizzaBuilder: PizzaBuilder {

    private var pizza = MegaPizza()

    func reset() {
        pizza = MegaPizza()
    }

    func createMain() {
        pizza.add("Main")
    }

    func addCheese() {
        pizza.add("Cheese")
    }

    func addSause() {
        pizza.add("Sause")
    }

    func addChicken() {
        pizza.add("Chicken")
    }

    func getPizza() -> MegaPizza {
        return pizza
    }
}

final class CheesePizzaBuilder: PizzaBuilder {

    private var pizza = CheesePizza()

    func reset() {
        pizza = CheesePizza()
    }

    func createMain() {
        pizza.add("Main")
    }

    func addCheese() {
        pizza.add("Cheese")
    }

    func addSause() {
        pizza.add("Sause")
    }

    func addChicken() {
        pizza.add("Chicken")
    }

    func getPizza() -> CheesePizza {
        return pizza
    }
}

final class BasicPizza {
    private var parts: [String] = []
    func add(_ part: String) { parts.append(part) }
    func listOfParts() -> String { parts.joined(separator: ",") }
}

final class CheesePizza {
    private var parts: [String] = []
    func add(_ part: String) { parts.append(part) }
    func listOfParts() -> String { parts.joined(separator: ",") }
}

final class MegaPizza {
    private var parts: [String] = []
    func add(_ part: String) { parts.append(part) }
    func listOfParts() -> String { parts.joined(separator: ",") }
}

final class PizzaDirector {
    private var builder: PizzaBuilder

    init(builder: PizzaBuilder) { self.builder = builder }
    func update(builder: PizzaBuilder) { self.builder = builder }

    func makeBasicPizza() {
        builder.createMain()
        builder.addSause()
    }

    func makeCheesePizza() {
        builder.createMain()
        builder.addCheese()
    }

    func makeMegaPizza() {
        builder.createMain()
        builder.addSause()
        builder.addCheese()
        builder.addChicken()
    }
}

class App {
    func main() {
        // With Director
        let builder1 = CheesePizzaBuilder()
        let director = PizzaDirector(builder: builder1)
        director.makeCheesePizza()
        print(builder1.getPizza().listOfParts())
        director.makeMegaPizza()
        print(builder1.getPizza().listOfParts())

        // Only builder
        let builder2 = MegaPizzaBuilder()
        builder2.createMain()
        builder2.addCheese()
        builder2.addChicken()
        print(builder2.getPizza().listOfParts())
    }
}

let app = App()
app.main()

/*
 Output:
 Main,Cheese
 Main,Cheese,Main,Sause,Cheese,Chicken
 Main,Cheese,Chicken
 */
