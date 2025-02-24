//
//  AnimatedSetGameModel.swift
//  AnimatedSetGame
//
//  Created by 김도현 on 2/22/25.
//

import Foundation
import SwiftUI

struct AnimatedSetGameModel {
    private(set) var deck: [Card] = []
    private(set) var showingCards: [Card] = []
    private(set) var disCardedCards: [Card] = []
    
    mutating func createGame() {
        if !deck.isEmpty || !showingCards.isEmpty {
            deck.removeAll()
            showingCards.removeAll()
        }
        
        createDeck()
        createShowingCards()
    }
    
    private mutating func createDeck() {
        for shape in Card.Shape.allCases {
            for numberOfContents in Card.NumberOfContents.allCases {
                for color in Card.Color.allCases {
                    for shading in Card.Shading.allCases {
                        let cardKey = "\(shape)-\(numberOfContents)-\(color)-\(shading)"
                        let newCard = Card(id: cardKey, content: shape, numberOfContents: numberOfContents, color: color, shading: shading)
                        
                        if checkDeckIsSet(newCard) {
                            deck.append(newCard)
                        } else {
                            print("Error")
                        }
                    }
                }
            }
        }
        deck.shuffle()
    }
    
    private func checkDeckIsSet(_ newCard: Card) -> Bool {
        guard !newCard.id.isEmpty else { return false }
        
        return deck.filter { $0.id == newCard.id }.count == 0
    }
    
    private mutating func createShowingCards() {
        guard !deck.isEmpty else { return }
        
        for _ in 0..<12 {
            guard let cardToShow = deck.popLast() else { continue }
            showingCards.append(cardToShow)
        }
    }
    
    mutating func addThreeCardsToShowingCards() {
        guard !deck.isEmpty else { return }
        for _ in 0..<3 {
            guard let cardToShow = deck.popLast() else { continue }
            showingCards.append(cardToShow)
        }
    }
    
    mutating func chooseCard(_ card: Card) {
        if let index = showingCards.firstIndex(of: card) {
            showingCards[index].isSelected.toggle()
        }
    }
    
    struct Card: Identifiable, Hashable {
        var id: String
        var isSelected: Bool = false
        var isMatched: Bool = false
        
        var content: Shape
        var numberOfContents: NumberOfContents
        var color: Color
        var shading: Shading
        
        enum CardMatched: CaseIterable {
            case Matched, NotMatched, UnDetermined
        }
        
        enum Shape: CaseIterable {
            case Diamond, Squiggle, Oval
        }
        
        enum NumberOfContents: Int, CaseIterable {
            case One = 1, Two = 2, Three = 3
        }
        
        enum Color: CaseIterable {
            case Red, Green, Blue
        }
        
        enum Shading: CaseIterable {
            case Solid, Stripped, Open
        }
    }
}

extension AnimatedSetGameModel.Card.Color {
    func toSwiftUIColor() -> Color {
        switch self {
        case .Red: return Color.red
        case .Green: return Color.green
        case .Blue: return Color.blue
        }
    }
}
