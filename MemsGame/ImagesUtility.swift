import Foundation
import UIKit

typealias CardsArray = [Card]

// MARK: - ImagesUtility
class ImagesUtility{

    static let shared = ImagesUtility()
    
    static var defaultCardImages:[UIImage] = [
        UIImage(named: "m1")!,
        UIImage(named: "m2")!,
        UIImage(named: "m3")!,
        UIImage(named: "m4")!,
        UIImage(named: "m5")!,
        UIImage(named: "m6")!,
        UIImage(named: "m7")!,
        UIImage(named: "m8")!
    ];
    
    func getCardImages(completion: ((CardsArray?, Error?) -> ())?) {
        var cards = CardsArray()
        let cardImages = ImagesUtility.defaultCardImages
        
        for image in cardImages {
            let card = Card(image: image)
            let copy = card.copy()
            
            cards.append(card)
            cards.append(copy)
        }	
        completion!(cards, nil)
    }
}
