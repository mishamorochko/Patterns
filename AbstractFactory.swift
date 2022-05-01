// MARK: - Abstract Factory

protocol UIKitFactory {
    func makeLabel() -> Label
    func makeButton() -> Button
}

class IOSFactory: UIKitFactory {
    func makeLabel() -> Label {
        return IOSLabel()
    }
    func makeButton() -> Button {
        return IOSButton()
    }
}

class MACOSFactory: UIKitFactory {
    func makeLabel() -> Label {
        return MACOSLabel()
    }
    func makeButton() -> Button {
        return MACOSButton()
    }
}

// MARK: - ABSTRACT INTERFACES

protocol Button {
    func setTitleText(_ text: String)
    func setColor(_ color: String)
    func setBackgroundColor(_ color: String)
}

protocol Label {
    func setText(_ text: String)
    func setColor(_ color: String)
    func setFont(_ font: String)
}

// MARK: - MACOS UIKIT

struct IOSLabel: Label {
    func setText(_ text: String) { print("IOSLabel -> setText()") }
    func setColor(_ color: String) { print("IOSLabel -> setColor()") }
    func setFont(_ font: String) { print("IOSLabel -> setFont()") }
}

struct IOSButton: Button {
    func setTitleText(_ text: String) { print("IOSButton -> setTitleText()") }
    func setColor(_ color: String) { print("IOSButton -> setColor()") }
    func setBackgroundColor(_ color: String) { print("IOSButton -> setBackgroundColor()") }
}

// MARK: - MACOS UIKIT

struct MACOSLabel: Label {
    func setText(_ text: String) { print("MACOSLabel -> setText()") }
    func setColor(_ color: String) { print("MACOSLabel -> setColor()") }
    func setFont(_ font: String) { print("MACOSLabel -> setFont()") }
}

struct MACOSButton: Button {
    func setTitleText(_ text: String) { print("MACOSButton -> setTitleText()") }
    func setColor(_ color: String) { print("MACOSButton -> setColor()") }
    func setBackgroundColor(_ color: String) { print("MACOSButton -> setBackgroundColor()") }
}

// MARK: - USAGE

class Application {
    private let factory: UIKitFactory

    private let button: Button
    private let label: Label

    init(factory: UIKitFactory) {
        self.factory = factory
        self.button = factory.makeButton()
        self.label = factory.makeLabel()
    }

    func setLabelText() {
        label.setText("Hi!")
    }

    func setButtonTitleText() {
        button.setTitleText("Hello!")
    }
}

class ApplicationConfigurator {
    private enum OS {
        case iOS
        case macOS
    }

    func main() {
        let systemType = readConfig()
        let factory: UIKitFactory
        switch systemType {
        case .iOS: factory = IOSFactory()
        case .macOS: factory = MACOSFactory()
        }

        let app = Application(factory: factory)
        app.setButtonTitleText()
        app.setLabelText()
    }

    private func readConfig() -> OS {
        return .macOS
    }
}

let appConfig = ApplicationConfigurator()
appConfig.main()

