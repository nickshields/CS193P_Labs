//
//  Concentration.swift
//  Concentration
//
//  Created by Nick Shields on 2020-04-13.
//  Copyright © 2020 Nick Shields. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    var flipCount = 0
    var score = 0
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    
    init(numberOfPairsOfCards: Int) {
        print("Creating Model!")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            //When you assign a struct, it makes a copy.
            cards += [card, card]
        }
        
        //This shuffles it!
        var shuffled_deck = [Card]()
        for _ in cards{
            let random = Int(arc4random_uniform(UInt32(cards.count)))
            shuffled_deck.append(cards.remove(at: random))
        }
        cards = shuffled_deck
        
        //TO-DO: Shuffle the Cards
        
    }
    func chooseCard(at index: Int){
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }else{
                //either no cards or two cards are face up
                for flipDownIndex in cards.indices{
                    if cards[flipDownIndex].isFaceUp == true {
                        if !cards[flipDownIndex].isMatched {
                            if cards[flipDownIndex].isSeen == true {
                            score -= 1
                        }
                        }
                        for index in cards.indices{
                            if cards[index].identifier == cards[flipDownIndex].identifier{
                                cards[index].isSeen = true
                            }
                        }
                        //cards[flipDownIndex].isSeen = true
                    }
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
}
