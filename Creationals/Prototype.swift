// Prototype
/// The Prototype pattern is available in Swift out of the box with a NSCopying interface.

import Foundation
class User: NSCopying {

    var name: String
    private let age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = User(name: name, age: age)
        return copy
    }
}

let user1 = User(name: "Mikhail", age: 22)
let user2 = user1.copy() as! User

user1.name = "Oleg"
print(user2.name)

/*
 Output:
 Mikhail
 */
