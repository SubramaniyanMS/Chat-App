//
//  ChatAppUITests.swift
//  Chat AppUITests
//
//  Created by Apple on 28/09/24.
//

import XCTest

class ChatAppUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testSendMessage() {
        let app = XCUIApplication()
        
        let inputTextView = app.textViews["MessageInputBarInputTextView"]
        inputTextView.tap()
        inputTextView.typeText("Hello, UI Test!")
        
        let sendButton = app.buttons["MessageInputBarSendButton"]
        sendButton.tap()
        
        let messageLabel = app.staticTexts["Hello, UI Test!"]
        XCTAssertTrue(messageLabel.exists, "The message should be visible in the chat.")
    }
    
    func testFetchMessages() {
        let app = XCUIApplication()
        
        let collectionView = app.collectionViews["MessagesCollectionView"]
        XCTAssertTrue(collectionView.exists, "The chat messages collection view should exist.")
        
        let firstMessage = collectionView.cells.firstMatch
        XCTAssertTrue(firstMessage.exists, "At least one message should be loaded.")
    }
}
