import Foundation
import UIKit

typealias CardsArray = [Card]

// MARK: - ImagesUtility
class ImagesUtility{
    
    static let shared = ImagesUtility()
    
    static var easyCardImages:[UIImage] = [
        UIImage(named: "m1")!,
        UIImage(named: "m2")!,
        UIImage(named: "m3")!,
        UIImage(named: "m4")!,
        UIImage(named: "m5")!,
        UIImage(named: "m6")!,
        UIImage(named: "m7")!,
        UIImage(named: "m8")!
    ];
    
    static var hardCardImages:[UIImage] = [
        UIImage(named: "m1")!,
        UIImage(named: "m2")!,
        UIImage(named: "m3")!,
        UIImage(named: "m4")!,
        UIImage(named: "m5")!,
        UIImage(named: "m6")!,
        UIImage(named: "m7")!,
        UIImage(named: "m8")!,
        UIImage(named: "m9")!,
        UIImage(named: "m10")!
    ];
    
    func getCardImagesEasy(completion: ((CardsArray?, Error?) -> ())?) {
        return getCardImages(cardImages: ImagesUtility.easyCardImages, completions: completion)
    }
    
    func getCardImagesHard(completion: ((CardsArray?, Error?) -> ())?) {
        return getCardImages(cardImages: ImagesUtility.hardCardImages, completions: completion)
    }
    
    func getCardImages(cardImages:[UIImage], completions: ((CardsArray?, Error?) -> ())?){
        var cards = CardsArray()
        for image in cardImages {
            let card = Card(image: image)
            let copy = card.copy()
            
            cards.append(card)
            cards.append(copy)
        }
        completions!(cards, nil)
    }
}
