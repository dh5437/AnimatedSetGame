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
    
    mutating func createDeck() {
        for shape in Card.Shape.allCases {
            for numberOfContents in Card.NumberOfContents.allCases {
                for color in Card.Color.allCases {
                    for shading in Card.Shading.allCases {
                        let cardKey = "\(shape)-\(numberOfContents)-\(color)-\(shading)"
                        
                        deck.append(Card(id: cardKey, content: shape, numberOfContents: numberOfContents, color: color, shading: shading))
                    }
                }
            }
        }
    }
    
    func checkDeckIsSet(deck: Array<Card>) -> Bool {
        guard !deck.isEmpty else { return false }
        
        let setDeck = Set(deck.map { $0.id })
        print(setDeck.count)
        return setDeck.count == deck.count
    }
    
    struct Card: Identifiable, Hashable {
        var id: String
        var isSelected: Bool = false
        var isMatched: CardMatched = .UnDetermined
        
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

extension AnimatedSetGameModel.Card.Color: ShapeStyle {
    func resolve() -> Color {
        switch self {
        case .Red: return Color.red
        case .Green: return Color.green
        case .Blue: return Color.blue
        }
    }
}
