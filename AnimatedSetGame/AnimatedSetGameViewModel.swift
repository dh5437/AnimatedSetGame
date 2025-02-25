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
    
    var showingCards: [Card] {
        return animatedSetGameModel.showingCards
    }
    
    var disCardedCards: [Card] {
        return animatedSetGameModel.disCardedCards
    }
    
    var areCardsMatched: Card.CardMatched {
        return animatedSetGameModel.areCardsMatched
    }
    
    var score: Int {
        return animatedSetGameModel.score
    }
    
    func createGame() {
        animatedSetGameModel.createGame()
    }
    
    func addThreeMoreCardsToShowingCards() {
        animatedSetGameModel.addThreeCardsToShowingCards()
    }
    
    func chooseCard(_ card: Card) {
        animatedSetGameModel.chooseCard(card)
    }
    
    func discardCard(_ card: Card) {
        animatedSetGameModel.discardCard(card)
    }
    
    func findMatchingCards(_ cards: [Card]) -> [Card]? {
        animatedSetGameModel.findMatchingCards(in: cards)
    }
}
