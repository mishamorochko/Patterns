// MARK: - Flyweight

class Flyweight {

    private let sharedState: [String]

    init(sharedState: [String]) {
        self.sharedState = sharedState
    }

    func operation(uniqueState: [String]) {
        print("Flyweight: Displaying shared (\(sharedState)) and unique (\(uniqueState) state.\n")
    }
}

class FlyweightFactory {

    private var flyweights: [String: Flyweight]

    init(states: [[String]]) {

        var flyweights = [String: Flyweight]()

        for state in states {
            flyweights[state.key] = Flyweight(sharedState: state)
        }

        self.flyweights = flyweights
    }

    func flyweight(for state: [String]) -> Flyweight {

        let key = state.key

        guard let foundFlyweight = flyweights[key] else {

            print("FlyweightFactory: Can't find a flyweight, creating new one.\n")
            let flyweight = Flyweight(sharedState: state)
            flyweights.updateValue(flyweight, forKey: key)
            return flyweight
        }
        print("FlyweightFactory: Reusing existing flyweight.\n")
        return foundFlyweight
    }

    func printFlyweights() {
        print("FlyweightFactory: I have \(flyweights.count) flyweights:\n")
        for item in flyweights {
            print(item.key)
        }
    }
}

extension Array where Element == String {
    var key: String {
        return self.joined()
    }
}

class App {
    func main() {
        let factory = FlyweightFactory(
            states:
                [
                    ["Chevrolet", "Camaro2018", "pink"],
                    ["Mercedes Benz", "C300", "black"],
                    ["Mercedes Benz", "C500", "red"],
                    ["BMW", "M5", "red"],
                    ["BMW", "X6", "white"]
                ])

        factory.printFlyweights()

        addCarToPoliceDatabase(
            factory,
            "CL234IR",
            "James Doe",
            "BMW",
            "M5",
            "red")

        addCarToPoliceDatabase(
            factory,
            "CL234IR",
            "James Doe",
            "BMW",
            "X1",
            "red")

        factory.printFlyweights()
    }

    func addCarToPoliceDatabase(
        _ factory: FlyweightFactory,
        _ plates: String,
        _ owner: String,
        _ brand: String,
        _ model: String,
        _ color: String) {

            print("Client: Adding a car to database.\n")

            let flyweight = factory.flyweight(for: [brand, model, color])

            flyweight.operation(uniqueState: [plates, owner])
        }
}

let app = App()
app.main()

/*
 Output:
 FlyweightFactory: I have 5 flyweights:

 BMWM5red
 BMWX6white
 Mercedes BenzC500red
 ChevroletCamaro2018pink
 Mercedes BenzC300black
 Client: Adding a car to database.

 FlyweightFactory: Reusing existing flyweight.

 Flyweight: Displaying shared (["BMW", "M5", "red"]) and unique (["CL234IR", "James Doe"] state.

 Client: Adding a car to database.

 FlyweightFactory: Can't find a flyweight, creating new one.

 Flyweight: Displaying shared (["BMW", "X1", "red"]) and unique (["CL234IR", "James Doe"] state.

 FlyweightFactory: I have 6 flyweights:

 BMWM5red
 BMWX6white
 BMWX1red
 Mercedes BenzC500red
 ChevroletCamaro2018pink
 Mercedes BenzC300black
 */
