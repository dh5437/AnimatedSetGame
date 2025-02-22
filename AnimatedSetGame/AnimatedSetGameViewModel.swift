//
//  AnimatedSetGameViewModel.swift
//  AnimatedSetGame
//
//  Created by 김도현 on 2/22/25.
//

import SwiftUI

class AnimatedSetGameViewModel: ObservableObject {
    typealias Card = AnimatedSetGameModel.Card
    @Published var animatedSetGameModel = AnimatedSetGameModel()
    
    var deck: [Card] {
        return animatedSetGameModel.deck
    }
    
    func createDeck() {
        animatedSetGameModel.createDeck()
    }
    
    func checkDeckIsSet(deck: Array<Card>) -> Bool {
        animatedSetGameModel.checkDeckIsSet(deck: deck)
    }
    
}
