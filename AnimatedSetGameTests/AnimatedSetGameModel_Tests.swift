//
//  AnimatedSetGameModel_Tests.swift
//  AnimatedSetGameTests
//
//  Created by 김도현 on 2/24/25.
//

import Testing
@testable import AnimatedSetGame

struct AnimatedSetGameModel_Tests {
    
    //    @Test func test_AnimatedSetGameModel_checkDeckIsSet_shouldBeTrue() async throws {
    //        // Given
    //        vm.createDeck()
    //        let deck = vm.deck
    //        // When
    //        let isDeckSet = model.checkDeckIsSet(deck: deck)
    //        // Then
    //        #expect(isDeckSet == true)
    //    }
    @Test func test_Model_createGame_shouldInitializeDeck() async throws {
        // Given
        var model = AnimatedSetGameModel()
        
        // When
        model.createGame()
        
        // Then
        #expect(!model.deck.isEmpty)
        #expect(model.showingCards.count == 12)
    }
}
