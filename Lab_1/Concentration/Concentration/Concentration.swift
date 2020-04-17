//
//  Concentration.swift
//  Concentration
//
//  Created by Nick Shields on 2020-04-13.
//  Copyright © 2020 Nick Shields. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    private(set) var flipCount = 0
    private(set) var score = 0
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
            //return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    }else{
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set{
            //either no cards or two cards are up
            for index in cards.indices {
                if cards[index].isFaceUp == true, !cards[index].isMatched, cards[index].isSeen == true {
                    score -= 1
                }
                if cards[index].isFaceUp == true, index != newValue {
                    cards[index].isSeen = true
                }
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(numberOfPairsOfCards: \(numberOfPairsOfCards): You need to have at least one pair of cards")
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
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not in the cards")
        flipCount += 1
        if !cards[index].isMatched {
            //choosing second card
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                cards[index].isFaceUp = true
            }else{
                //either no cards or two cards are face up
//                for flipDownIndex in cards.indices{
//                    if cards[flipDownIndex].isFaceUp == true {
//                        if !cards[flipDownIndex].isMatched {
//                            if cards[flipDownIndex].isSeen == true {
//                            score -= 1
//                        }
//                        }
//                        for index in cards.indices{
//                            if cards[index].identifier == cards[flipDownIndex].identifier{
//                                cards[index].isSeen = true
//                            }
//                        }
//                    }
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index //using computed properly to simplify
            }
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
