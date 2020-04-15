//
//  Card.swift
//  Concentration
//
//  Created by Nick Shields on 2020-04-13.
//  Copyright © 2020 Nick Shields. All rights reserved.
//

import Foundation

struct Card {
    //Major difference between class:
    //Structs have NO inheritance (makes them simpler than a class)
    //MOST IMPORTANCE DIFFERENCE: Structs are value types, classes are reference types  
    //STRUCTS == VALUE TYPES (Stuff gets copied when you pass it around)
    //Classes == think like pointers to objects etc
    
    var isFaceUp = false
    var isMatched = false
    var isSeen = false
    var identifier: Int
    
    //Static vars also don't get stored with individual instances of type
    //They only get stored with the Type: Card
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        //What is a static function/method?
        //These functions get stored with the Type: Card
        //An individual instance of Card doesn't understand it. (See how it's implemented below)
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
