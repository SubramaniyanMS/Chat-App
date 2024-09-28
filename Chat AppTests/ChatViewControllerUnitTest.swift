//
//  ChatViewControllerUnitTest.swift
//  Chat AppTests
//
//  Created by Apple on 28/09/24.
//

import XCTest
@testable import Chat_App
class ChatViewModelTests: XCTestCase {
    
    var viewModel: ChatViewModel!
    var mockNetworkingService: MockNetworkingService!
    
    override func setUp() {
        super.setUp()
        mockNetworkingService = MockNetworkingService()
        viewModel = ChatViewModel(networkingService: mockNetworkingService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkingService = nil
        super.tearDown()
    }
    
    func testFetchMessagesSuccess() {
        let mockMessages = [
            Message(id: 1, title: "Hello", body: "World", userId: 1),
            Message(id: 2, title: "Hi", body: "There", userId: 2)
        ]
        mockNetworkingService.mockMessages = mockMessages
        
        let expectation = self.expectation(description: "Fetch messages")
        viewModel.fetchMessages {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertEqual(self.viewModel.messages.count, 2)
        XCTAssertEqual(self.viewModel.messages[0].title, "Hello")
        XCTAssertEqual(self.viewModel.messages[1].body, "There")
    }
    
    func testFetchMessagesFailure() {
        mockNetworkingService.shouldReturnError = true
        
        let expectation = self.expectation(description: "Fetch messages with error")
        viewModel.fetchMessages {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertTrue(self.viewModel.messages.isEmpty)
    }
}

class MockNetworkingService: NetworkingServiceProtocol {
    var mockMessages: [Message]?
    var shouldReturnError = false
    
    func fetchMessages(completion: @escaping ([Message]?) -> Void) {
        if shouldReturnError {
            completion(nil)
        } else {
            completion(mockMessages)
        }
    }
}

