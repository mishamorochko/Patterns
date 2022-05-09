// Factory method

protocol Transport {
    func deliver()
}

protocol Logistic {
    func createTransport() -> Transport
}

class SeaLogistic: Logistic {
    func createTransport() -> Transport {
        return SeaTransport()
    }
}

class SeaTransport: Transport {
    func deliver() {
        print("SeaTransport deliver.")
    }
}

class RoadLogistic: Logistic {
    func createTransport() -> Transport {
        return RoadTransport()
    }
}

class RoadTransport: Transport {
    func deliver() {
        print("RoadTransport deliver.")
    }
}

class FlyLogistic: Logistic {
    func createTransport() -> Transport {
        return FlyTransport()
    }
}

class FlyTransport: Transport {
    func deliver() {
        print("FlyTransport deliver.")
    }
}

class App {
    func main() {
        deliver(logistic: FlyLogistic())
        getCoffee(coffeeShop: ItalianCoffeeShop())
    }

    private func deliver(logistic: Logistic) {
        logistic.createTransport().deliver()
    }

    private func getCoffee(coffeeShop: CoffeeShop) {
        let coffee = coffeeShop.createCoffee()
        coffee.pourIntoCup()
    }
}

let app = App()
app.main()

/*
 Output:
 FlyTransport deliver.
 ItalianCoffee pour into cup.
 */
