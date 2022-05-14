// MARK: - Iterator
enum WordCollectionIterator {
    case standard
    case reverse
}

class AdvancedWordCollection {
    var items = [String]()
    private var type: WordCollectionIterator
    func add(_ item: String) { items.append(item) }
    init(iterationType type: WordCollectionIterator) { self.type = type }
}

extension AdvancedWordCollection: Sequence {
    func makeIterator() -> UniversalIterator {
        return UniversalIterator(self, iterationType: type)
    }
}

class UniversalIterator: IteratorProtocol {
    private var type: WordCollectionIterator
    private var collection: AdvancedWordCollection
    private var index = 0
    init(_ collection: AdvancedWordCollection, iterationType type: WordCollectionIterator) {
        self.collection = collection
        self.type = type
        switch type {
        case .standard: index = 0
        case .reverse: index = collection.items.count - 1
        }
    }

    func next() -> String? {
        switch type {
        case .standard:
            defer { index += 1 }
            return index < collection.items.count ? collection.items[index] : nil
        case .reverse:
            defer { index -= 1 }
            return index >= 0 ? collection.items[index] : nil
        }
    }

}

class Client {
    static func clientCode<S: Sequence>(sequence: S) {
        for item in sequence {
            print(item)
        }
    }
}

class App {
    func main() {
        let words = AdvancedWordCollection(iterationType: .reverse)
        words.add("Hello")
        words.add("World")
        Client.clientCode(sequence: words)
        print("-----")
        let words2 = AdvancedWordCollection(iterationType: .reverse)
        words2.add("One")
        words2.add("Two")
        words2.add("Three")
        words2.add("Four")
        Client.clientCode(sequence: words2)
    }
}

let app = App()
app.main()

/*
 Output:
 World
 Hello
 -----
 Four
 Three
 Two
 One
 */

// Some example for separated basic and reverse iterator.
class WordsReverseIterator: IteratorProtocol {
    private var collection: AdvancedWordCollection
    private var index = 0
    init(_ collection: AdvancedWordCollection) {
        self.collection = collection
        index = collection.items.count - 1
    }
    func next() -> String? {
        defer { index -= 1 }
        return index >= 0 ? collection.items[index] : nil
    }
}

class WordsBasicIterator: IteratorProtocol {
    private var collection: AdvancedWordCollection
    private var index = 0
    init(_ collection: AdvancedWordCollection) {
        self.collection = collection
    }
    func next() -> String? {
        defer { index += 1 }
        return index < collection.items.count ? collection.items[index] : nil
    }
}
