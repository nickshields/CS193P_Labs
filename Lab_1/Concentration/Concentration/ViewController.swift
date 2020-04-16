//
//  ViewController.swift
//  Concentration
//
//  Created by Nick Shields on 2020-04-13.
//  Copyright © 2020 Nick Shields. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //In swift, nil means an optional that was not set
    // ! = assume this optional was set, grab the associating value.
    //Instance Variables (We call them properties in swift)
    //Initialize using init or just set their initial value
    //Swift has strong inferencing abilities
    
    //MARK: Instance Variables/Properties
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    //lazy vars don't initialize until someone tries to use it
    var numberOfPairsOfCards: Int {
        return((cardButtons.count + 1)/2)
    }
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    private var themes = [ 1: ["🎃", "💍", "⛑", "👻", "🙄", "🤔"],
                   2: ["😆", "😇", "☺️", "😚", "👓", "😏"],
                   3: ["🐰", "🦊", "🐨", "🐼", "🐻", "🐯"],
                   4: ["🐞", "🐌", "🐝", "🦄", "🐺", "🐜"],
                   5: ["🐛", "🦂", "🦛", "🐆", "🦓", "🐊"],
                   6: ["🦒", "🦘", "🐃", "🐎", "🐄", "🐂"]
    ]
    
    private var emojiChoices = ["🎃", "💍", "⛑", "👻", "🙄", "🤔"]
    private var emoji = [Int:String]()
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("Chosen card was not in cardButtons.")
        }
        
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        //Re-init the game, set the flip count to zero and update the view.
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2)
        updateViewFromModel()
        //pick new theme
        self.emojiChoices = self.themes[Int(arc4random_uniform(UInt32(themes.count))) - 1]! //Force unwrap since it will always work!
        self.emoji = [Int:String]()
    }
    
    
    private func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
            }
            
        }
        flipCountLabel.text = "Flip Count: \(game.flipCount)"
        scoreLabel.text = "Score \(game.score)"
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
        return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        }else{
            return 0
        }
    }
}
