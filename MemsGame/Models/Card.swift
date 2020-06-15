import UIKit

class Card {
    
    // MARK: - Properties
    
    var id: String
    var shown: Bool = false
    var image: UIImage!
    
    static var allCards = [Card]()
    
    init(card: Card) {
        self.id = card.id
        self.shown = card.shown
        self.image = card.image
    }
    
    init(image: UIImage) {
        self.id = NSUUID().uuidString
        self.shown = false
        self.image = image
    }
    
    // MARK: - Methods
    
    func equals(_ card: Card) -> Bool {
        return (card.id == id)
    }
    
    func copy() -> Card {
        return Card(card: self)
    }
}

extension Array {
    mutating func shuffle() {
        for _ in 0...self.count {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
