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
        // When
        vm.createDeck()
        let deck = vm.deck
        // Then
        #expect(!deck.isEmpty)
        #expect(deck.count == 81)
    }
}
