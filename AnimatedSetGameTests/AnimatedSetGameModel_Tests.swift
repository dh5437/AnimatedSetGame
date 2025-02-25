//
//  AnimatedSetGameModel_Tests.swift
//  AnimatedSetGameTests
//
//  Created by 김도현 on 2/24/25.
//

import Testing
@testable import AnimatedSetGame

struct AnimatedSetGameModel_Tests {
    var model = AnimatedSetGameModel()
    
    //    @Test func test_AnimatedSetGameModel_checkDeckIsSet_shouldBeTrue() async throws {
    //        // Given
    //        vm.createDeck()
    //        let deck = vm.deck
    //        // When
    //        let isDeckSet = model.checkDeckIsSet(deck: deck)
    //        // Then
    //        #expect(isDeckSet == true)
    //    }
    @MainActor
    @Test mutating func test_AnimatedSetGameModel_createGame_shouldInitializeDeck() async throws {
        // Given
        // When
        model.createGame()
        
        // Then
        #expect(!model.deck.isEmpty)
        #expect(model.showingCards.count == 12)
    }
        
    @MainActor
    @Test mutating func test_AnimatedSetGameModel_addThreeCardsToShowingCards_shouldAddThreeCardsToShowingCards() async throws {
        // Given
        model.createGame()
        
        // When
        let initialCount = model.showingCards.count
        model.addThreeCardsToShowingCards()
        
        // Then
        #expect(!model.showingCards.isEmpty)
        #expect(model.showingCards.count == initialCount + 3)
    }
    
    @MainActor
    @Test mutating func test_AnimatedSetGameModel_addThreeCardsToShowingCards_shouldAddThreeCardsToShowingCards_stress() async throws {
        // Given
        model.createGame()
        
        // When
        let initialCount = model.showingCards.count
        
        let randomCount = Int.random(in: 0..<model.deck.count)
        
        for _ in 0..<randomCount {
            model.addThreeCardsToShowingCards()
        }
        
        // Then
        #expect(!model.showingCards.isEmpty)
        #expect(model.showingCards.count == initialCount + 3 * randomCount)
    }
    
    @MainActor
    @Test mutating func test_AnimatedSetGameModel_addThreeCardsToShowingCards_shouldNotAddThreeCardsWhenNoCardsInDeck() async throws {
        // Given
        model.createGame()
        
        let addCount = model.deck.count / 3
        
        for _ in 0..<addCount {
            model.addThreeCardsToShowingCards()
        }
        
        // When
        let countAfterAddedAllCards = model.showingCards.count
        #expect(countAfterAddedAllCards == 81)
        #expect(model.deck.count == 0)
        
        model.addThreeCardsToShowingCards()
        
        // Then
        #expect(model.showingCards.count == countAfterAddedAllCards)
    }
    
    @MainActor
    @Test mutating func test_AnimatedSetGameViewModel_chooseCard_shouldMakeCardSelected() async throws {
        // Given
        model.createGame()
        // When
        guard !model.showingCards.isEmpty else {
            return
        }
        
        let randomNumber = Int.random(in: 0..<model.showingCards.count)
        #expect(!model.showingCards[randomNumber].isSelected)
        
        model.chooseCard(model.showingCards[randomNumber])
        // Then
        #expect(model.showingCards[randomNumber].isSelected)
    }
    
    @MainActor
    @Test mutating func test_AnimatedSetGameViewModel_chooseCard_shouldMakeCardSelected_stress() async throws {
        // Given
        model.createGame()
        // When
        guard !model.showingCards.isEmpty else {
            return
        }
        
        let randomCount = Int.random(in: 0..<100)
        print("randomCount: \(randomCount)")
        
        for _ in 0..<randomCount {
            let randomNumber = Int.random(in: 0..<model.showingCards.count)
                        
            model.chooseCard(model.showingCards[randomNumber])
            #expect(model.showingCards[randomNumber].isSelected)
            model.chooseCard(model.showingCards[randomNumber])
            #expect(!model.showingCards[randomNumber].isSelected)
        }
        
        // Then
        #expect(!model.showingCards[Int.random(in: 0..<model.showingCards.count)].isSelected)
    }
    
    @MainActor
    @Test mutating func test_AnimatedSetGameModel_chooseCard_shouldNotDiscardCardsWhenLessThanThreeSelected() async throws {
        // Given
        model.createGame()
        guard !model.showingCards.isEmpty else {
            return
        }
        
        // When
        model.chooseCard(model.showingCards[0])
        #expect(model.showingCards.count == 12)
        
        model.chooseCard(model.showingCards[1])
        
        // Then
        #expect(model.showingCards.count == 12)
    }
    
    @MainActor
    @Test mutating func test_AnimatedSetGameModel_chooseCard_shouldDiscardCardsWhenMatched() async throws {
        // Given
        model.createGame()
        let initialCount = model.showingCards.count
        // When
        let foundCards = model.findMatchingCards(in: model.showingCards)
        guard let matchedCards = foundCards else {
            #expect(foundCards == nil)
            return
        }
        #expect(matchedCards.count == 3)

        // Then
        matchedCards.forEach({ card in
            model.chooseCard(card)
        })
        #expect(model.showingCards.count == initialCount)
        #expect(model.disCardedCards.count == 3)
    }
    
    @MainActor
    @Test mutating func test_AnimatedSetGameModel_chooseCard_shouldNotAddCardsWhenShowingCardsAreNotLessThanTwelve() async throws {
        // Given
        model.createGame()
        model.addThreeCardsToShowingCards()
        let initialCount = model.showingCards.count
        // When
        let foundCards = model.findMatchingCards(in: model.showingCards)
        guard let matchedCards = foundCards else {
            #expect(foundCards == nil)
            return
        }
        #expect(matchedCards.count == 3)

        // Then
        matchedCards.forEach({ card in
            model.chooseCard(card)
        })
        #expect(model.showingCards.count == initialCount - 3)
    }
}
