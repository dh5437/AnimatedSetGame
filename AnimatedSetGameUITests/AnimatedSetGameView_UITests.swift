//
//  AnimatedSetGameView_UITests.swift
//  AnimatedSetGameUITests
//
//  Created by 김도현 on 2/24/25.
//

import XCTest

final class AnimatedSetGameView_UITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
    }

    func test_AnimatedSetGameView_VStack_ShouldCreateGameWhenAppeared() throws {
        // Given
        // When
        
        let cardElements = app.otherElements.matching(identifier: "CardElement").allElementsBoundByIndex
        if let lastCard = cardElements.last {
            let exists = lastCard.waitForExistence(timeout: 5)
            XCTAssertTrue(exists)
        }
        // Then
        
        XCTAssertFalse(cardElements.isEmpty)
        XCTAssertEqual(cardElements.count, 12, "12 cards should be displayed after game starts")
    }
    
    func test_AnimatedSetGameView_AddThreeCardsButton_ShouldAddThreeCardsToGameWhenTapped() throws {
        // Given
        let cardElements = app.otherElements.matching(identifier: "CardElement").allElementsBoundByIndex
        if let lastCard = cardElements.last {
            let exists = lastCard.waitForExistence(timeout: 5)
            XCTAssertTrue(exists)
        }
        
        print("cardElement: \(cardElements)")
        
        // When
        app.buttons["Add3MoreCardsButton"].tap()
        let addedCardElements = app.otherElements.matching(identifier: "CardElement").allElementsBoundByIndex
        if let lastAddedCard = addedCardElements.last {
            let exists = lastAddedCard.waitForExistence(timeout: 3)
            XCTAssertTrue(exists)
        }
        
        // Then
        XCTAssertEqual(addedCardElements.count, 15, "3 more cards should be added")
    }
    
    func test_AnimatedSetGameView_NewGameButton_ShouldCreateNewGame() throws {
        // Given
        let cardElements = app.otherElements.containing(.any, identifier: "CardElement").allElementsBoundByIndex
        
        if let lastCard = cardElements.last {
            let exists = lastCard.waitForExistence(timeout: 5)
            XCTAssertTrue(exists)
            print("\(lastCard.identifier)")
        }
        
        let oldCardIDs = cardElements.map { $0.identifier }
        
        // When
        app.buttons["StartNewGameButton"].tap()
        let newCardElements = app.otherElements.matching(identifier: "CardElement").allElementsBoundByIndex
        
        if let lastCard = newCardElements.last {
            let exists = lastCard.waitForExistence(timeout: 5)
            XCTAssertTrue(exists)
        }
        
        let newCardIDs = newCardElements.map { $0.identifier }
            
        // Then
        
        XCTAssertFalse(newCardElements.isEmpty)
        XCTAssertEqual(newCardElements.count, 12, "12 cards should be displayed after game starts")
        
        XCTAssertNotEqual(Set(oldCardIDs), Set(newCardIDs), "New game should have different cards than the previous game")
    }
    
}
