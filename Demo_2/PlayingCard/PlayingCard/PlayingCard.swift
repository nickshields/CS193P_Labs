//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by Nick Shields on 2020-04-21.
//  Copyright © 2020 Nick Shields. All rights reserved.
//

import Foundation

struct PlayingCard: CustomStringConvertible{
    
    var description: String{ return "\(suit)\(rank)"}
    
    var suit: Suit
    var rank: Rank
    
    //Raw value type is Int assigns spades=0, hearts=1 etc..
    enum Suit: String, CustomStringConvertible {
        var description: String { return self.rawValue }
        
        
        
        case spades = "♠️"
        case hearts = "♥️"
        case diamonds = "♦️"
        case clubs = "♣️"
        
        static var all = [Suit.spades, .hearts, .diamonds, .clubs]
    }
    
    enum Rank: CustomStringConvertible{
        var description: String {
            return "cool"
        }
        
        case ace
        case face(String)
        case numeric(Int)
        
        
        var order: Int {
            switch self {
            case .ace: return 1
            case .numeric(let pips): return pips
            case .face(let kind) where kind == "J": return 11
            case .face(let kind) where kind == "Q": return 12
            case .face(let kind) where kind == "K": return 13
            default: return 0
            }
        }
        
        static var all: [Rank] {
            var allRanks: [Rank] = [.ace]
            for pips in 2...10{
                allRanks.append(Rank.numeric(pips))
            }
            allRanks += [Rank.face("J"), .face("Q"), .face("K")]
            
            return allRanks
        }
        
    }
    
}
