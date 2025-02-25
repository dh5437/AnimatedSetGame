//
//  AnimatedSetGameModel.swift
//  AnimatedSetGame
//
//  Created by 김도현 on 2/22/25.
//

import Foundation

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
            guard var cardToShow = deck.popLast() else { continue }
            cardToShow.isFaceUp = true
            showingCards.append(cardToShow)
        }
        
    }
    
    mutating func addThreeCardsToShowingCards() {
        guard !deck.isEmpty else { return }
        for _ in 0..<3 {
            guard var cardToShow = deck.popLast() else { continue }
            cardToShow.isFaceUp = true
            showingCards.append(cardToShow)
        }
    }
    
    mutating func chooseCard(_ card: Card) {
        if let index = showingCards.firstIndex(of: card) {
            if showingCards[index].isMatched == .NotMatched {
                showingCards[index].isMatched = .Selected
            } else if showingCards[index].isMatched == .Selected {
                showingCards[index].isMatched = .NotMatched
            }
        } else {
            print("Error in choosing card with id: \(card.id)")
            return
        }
        
        let selectedCards = showingCards.filter({ $0.isMatched == .Selected })
        
        guard selectedCards.count == 3 else {
            return
        }
        
        if checkCardsAreMatched(selectedCards) {
            selectedCards.forEach { card in
                if let index = showingCards.firstIndex(of: card) {
                    showingCards[index].isMatched = .Matched
                    discardCard(showingCards[index])
                } else {
                    print("Error in selecting card with id: \(card.id)")
                }
            }
            if showingCards.count < 12 {
                addThreeCardsToShowingCards()
            }
        } else {
            selectedCards.forEach { card in
                if let index = showingCards.firstIndex(of: card) {
                    showingCards[index].isMatched = .NotMatched
                } else {
                    print("Error in unselecting card with id: \(card.id)")
                }
            }
        }
    }
    
    mutating func discardCard(_ card: Card) -> Void {
        if let index = showingCards.firstIndex(of: card) {
            disCardedCards.append(showingCards.remove(at: index))
        } else {
            print("Error in discarding card with id: \(card.id)")
            return
        }
    }
    
    private func checkCardsAreMatched(_ cards: [Card]) -> Bool {
        return
            allElementsAreSameOrNot(cards[0].color, cards[1].color, cards[2].color)
            && allElementsAreSameOrNot(cards[0].content, cards[1].content, cards[2].content)
            && allElementsAreSameOrNot(cards[0].numberOfContents, cards[1].numberOfContents, cards[2].numberOfContents)
            && allElementsAreSameOrNot(cards[0].shading, cards[1].shading, cards[2].shading)
    }
    
    private func allElementsAreSameOrNot<Element: Equatable>(_ element1: Element, _ element2: Element, _ element3: Element) -> Bool {
        
        return (element1 == element2 && element1 == element3) || (element1 != element2 && element1 != element3 && element2 != element3)
    }
    
    func findMatchingCards(in cards: [Card]) -> [Card]? {
        let count = cards.count
        
        guard count >= 3 else { return nil } // 최소 3장 이상 있어야 함
        
        // 모든 가능한 3장 조합 검사
        for i in 0..<count {
            for j in (i+1)..<count {
                for k in (j+1)..<count {
                    let selectedCards = [cards[i], cards[j], cards[k]]
                    
                    if checkCardsAreMatched(selectedCards) {
                        return selectedCards
                    }
                }
            }
        }
        
        return nil
    }

    struct Card: Identifiable, Hashable {
        var id: String
        var isMatched: CardMatched = .NotMatched
        var isFaceUp: Bool = false
        
        var content: Shape
        var numberOfContents: NumberOfContents
        var color: Color
        var shading: Shading
        
        enum CardMatched: CaseIterable {
            case Matched, NotMatched, Selected
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

