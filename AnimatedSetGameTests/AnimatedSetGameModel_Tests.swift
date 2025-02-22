//
//  AnimatedSetGameModel_Tests.swift
//  AnimatedSetGameTests
//
//  Created by 김도현 on 2/22/25.
//

import Testing
@testable import AnimatedSetGame

struct AnimatedSetGameModel_Tests {
    
    var model = AnimatedSetGameModel()
    var vm = AnimatedSetGameViewModel()

    @Test func test_AnimatedSetGameModel_checkDeckIsSet_shouldBeTrue() async throws {
        // Given
        vm.createDeck()
        let deck = vm.deck
        // When
        let isDeckSet = model.checkDeckIsSet(deck: deck)
        // Then
        #expect(isDeckSet == true)
    }
}
