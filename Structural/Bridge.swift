// MARK: - Bridge

class BasicHeadphone {
    func playBass() { print("BasicHeadphone playBass.") }
    func playMid() { print("BasicHeadphone playMid.") }
}

class ExpensiveHeadphone: BasicHeadphone {
    override func playMid() { print("ExpensiveHeadphone playBass.") }
    override func playBass() { print("ExpensiveHeadphone playMid.") }
}

class CheapHeadphone: BasicHeadphone {
    override func playMid() { print("CheapHeadphone playBass.") }
    override func playBass() { print("CheapHeadphone playMid.") }
}

class MusicPlayer {
    private let headphone: BasicHeadphone
    init(headphone: BasicHeadphone) { self.headphone = headphone }
    func playMusic() {
        headphone.playBass()
        headphone.playMid()
        headphone.playBass()
    }
}

class App {
    func main() {
        let player = MusicPlayer(headphone: CheapHeadphone())
        player.playMusic()
    }
}

let app = App()
app.main()

/*
 Output:
 CheapHeadphone playMid.
 CheapHeadphone playBass.
 CheapHeadphone playMid.
 */
