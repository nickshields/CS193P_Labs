//
//  ViewController.swift
//  PlayingCard
//
//  Created by Nick Shields on 2020-04-21.
//  Copyright © 2020 Nick Shields. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for _ in 1...10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
    }


}

