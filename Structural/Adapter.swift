// MARK: - Adapter
class FacebookAuthSDK {
    func presentAuthFlow() { print("FacebookAuthSDK present auth flow.") }
}

class TwitterAuthSDK {
    func showAuth() { print("TwitterAuthSDK show auth.") }
}

protocol AuthService {
    func presentAuthFlow()
}

extension FacebookAuthSDK: AuthService { }

extension TwitterAuthSDK: AuthService {
    func presentAuthFlow() {
        showAuth()
    }
}

class App {
    func main() {
        startAuthorization(authSDK: TwitterAuthSDK())
    }

    private func startAuthorization(authSDK: AuthService) {
        authSDK.presentAuthFlow()
    }
}

let app = App()
app.main()

/*
 Output:
 TwitterAuthSDK show auth.
 */
