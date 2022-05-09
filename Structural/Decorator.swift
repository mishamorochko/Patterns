// MARK: - Decorator
protocol Phone {
    func apply() -> String
}

class MyPhone: Phone {
    func apply() -> String {
        return "MyPhone"
    }
}

class PhoneDecorator: Phone {
    private var phone: Phone
    init(phone: Phone) { self.phone = phone }
    func apply() -> String {
        phone.apply()
    }
}

class PhoneCaseDecorator: PhoneDecorator {
    override func apply() -> String {
        return "Phone case + \(super.apply())"
    }
}

class TemperedGlassDecorator: PhoneDecorator {
    override func apply() -> String {
        return "Tempered glass + \(super.apply())"
    }
}

class FishEyeCameraLensDecorator: PhoneDecorator {
    override func apply() -> String {
        return "Fish eye camera lens + \(super.apply())"
    }
}

class App {
    func main() {
        let phone = MyPhone()
        Client.printAllPhoneDetails(phone: phone)

        let phoneWithEyeFish = FishEyeCameraLensDecorator(phone: phone)
        Client.printAllPhoneDetails(phone: phoneWithEyeFish)

        let phoneWithTemperedAndFishEyeOptions = TemperedGlassDecorator(phone: phoneWithEyeFish)
        let phoneWithAllOptions = PhoneCaseDecorator(phone: phoneWithTemperedAndFishEyeOptions)
        Client.printAllPhoneDetails(phone: phoneWithAllOptions)
    }
}

let app = App()
app.main()

/*
 Output:
 MyPhone
 Fish eye camera lens + MyPhone
 Phone case + Tempered glass + Fish eye camera lens + MyPhone
 */
