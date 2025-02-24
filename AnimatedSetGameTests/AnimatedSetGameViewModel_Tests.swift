//
//  AnimatedSetGameModel_Tests.swift
//  AnimatedSetGameTests
//
//  Created by 김도현 on 2/22/25.
//

import Testing
@testable import AnimatedSetGame

struct AnimatedSetGameViewModel_Tests {
    
    let vm = AnimatedSetGameViewModel()
    
    @Test func test_AnimatedSetGameViewModel_createDeck_shouldCreateDeck() async throws {
        // Given
        vm.createGame()
        // When
        let deck = vm.deck
        let showingCards = vm.showingCards
        // Then
        #expect(!deck.isEmpty)
        #expect(showingCards.count == 12)
        #expect(deck.count == 69)
    }
    
    @Test func test_AnimatedSetGameViewModel_createDeck_shouldNotHaveDuplicatedCard() async throws {
        // Given
        vm.createGame()
        
        // When
        var deckSet: Set<String> = []
        for card in vm.deck {
            deckSet.insert(card.id)
        }
        
        // Then
        #expect(deckSet.count == 69)
    }
    
    @Test func test_AnimatedSetGameViewModel_createDeck_shouldDeleteAllCardsBeforeCreateNewDeck() async throws {
        // Given
        vm.createGame()
        
        // When
        vm.createGame()
        
        // Then
        #expect(vm.deck.count == 69)
        #expect(vm.showingCards.count == 12)
    }
    
    @Test func test_AnimatedSetGameViewModel_addThreeMoreCardsToShowingCards_shouldAddThreeMoreCardsToShowingCards() async throws {
        // Given
        vm.createGame()
        
        // When
        vm.addThreeMoreCardsToShowingCards()
        
        // Then
        #expect(vm.deck.count == 66)
        #expect(vm.showingCards.count == 15)
    }

    @Test func test_AnimatedSetGameViewModel_addThreeMoreCardsToShowingCards_shouldAddThreeMoreCardsToShowingCards_stress() async throws {
        // Given
        vm.createGame()
        // When
        let count = Int.random(in: 0..<20)
        
        for _ in 0..<count {
            vm.addThreeMoreCardsToShowingCards()
        }
        
        // Then
        #expect(vm.showingCards.count == 12 + count * 3)
        #expect(vm.deck.count == 69 - count * 3)
    }
    
    @Test func test_AnimatedSetGameViewModel_addThreeMoreCardsToShowingCards_shouldNotAddThreeMoreCardsWhenNoCardsInDeck() async throws {
        // Given
        vm.createGame()
        // When
        for _ in 0..<23 {
            vm.addThreeMoreCardsToShowingCards()
        }
        
        #expect(vm.showingCards.count == 81)
        #expect(vm.deck.isEmpty)
        
        vm.addThreeMoreCardsToShowingCards()
        
        // Then
        #expect(vm.showingCards.count == 81)
        #expect(vm.deck.isEmpty)
    }
    
    @Test func test_AnimatedSetGameViewModel_chooseCard_shouldMakeCardSelected() async throws {
        // Given
        vm.createGame()
        // When
        guard !vm.showingCards.isEmpty else {
            return
        }
        let randomNumber = Int.random(in: 0..<vm.showingCards.count)
        #expect(!vm.showingCards[randomNumber].isSelected)
        
        vm.chooseCard(vm.showingCards[randomNumber])
        // Then
        #expect(vm.showingCards[randomNumber].isSelected)
    }
    
    @Test func test_AnimatedSetGameViewModel_chooseCard_shouldMakeCardSelected_stress() async throws {
        // Given
        vm.createGame()
        // When
        guard !vm.showingCards.isEmpty else {
            return
        }
        
        let randomCount = Int.random(in: 0..<100)
        print("randomCount: \(randomCount)")
        
        for _ in 0..<randomCount {
            let randomNumber = Int.random(in: 0..<vm.showingCards.count)
                        
            vm.chooseCard(vm.showingCards[randomNumber])
            #expect(vm.showingCards[randomNumber].isSelected)
            vm.chooseCard(vm.showingCards[randomNumber])
            #expect(!vm.showingCards[randomNumber].isSelected)
        }
        
        // Then
        #expect(!vm.showingCards[Int.random(in: 0..<vm.showingCards.count)].isSelected)
    }

}
