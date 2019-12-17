//
//  Created by Tapash Majumder on 12/4/19.
//  Copyright © 2019 Iterable. All rights reserved.
//

import XCTest

@testable import IterableSDK

class InboxViewControllerViewModelTests: XCTestCase {
    override func setUp() {
        super.setUp()
        
        TestUtils.clearTestUserDefaults()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDescendingSorting() {
        let expectation1 = expectation(description: "testDescendingSorting")
        
        let model = InboxViewControllerViewModel()
        model.comparator = IterableInboxViewController.DefaultComparator.descending
        
        let fetcher = MockInAppFetcher()
        
        IterableAPI.initializeForTesting(
            inAppFetcher: fetcher
        )
        
        let date1 = Date()
        let date2 = date1.addingTimeInterval(5.0)
        let messages = [
            IterableInAppMessage(messageId: "message1",
                                 campaignId: "",
                                 trigger: IterableInAppTrigger(dict: [JsonKey.InApp.type: "never"]),
                                 createdAt: date1,
                                 content: IterableHtmlInAppContent(edgeInsets: .zero, backgroundAlpha: 0.0, html: ""),
                                 saveToInbox: true,
                                 inboxMetadata: nil,
                                 customPayload: nil),
            IterableInAppMessage(messageId: "message2",
                                 campaignId: "",
                                 trigger: IterableInAppTrigger(dict: [JsonKey.InApp.type: "never"]),
                                 createdAt: date2,
                                 content: IterableHtmlInAppContent(edgeInsets: .zero, backgroundAlpha: 0.0, html: ""),
                                 saveToInbox: true,
                                 inboxMetadata: nil,
                                 customPayload: nil),
        ]
        fetcher.mockMessagesAvailableFromServer(messages: messages)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            model.beganUpdates()
            XCTAssertEqual(model.message(atIndexPath: IndexPath(row: 0, section: 0)).iterableMessage.messageId, "message2")
            XCTAssertEqual(model.message(atIndexPath: IndexPath(row: 1, section: 0)).iterableMessage.messageId, "message1")
            expectation1.fulfill()
        }
        
        wait(for: [expectation1], timeout: testExpectationTimeout)
    }
    
    func testAscendingSorting() {
        let expectation1 = expectation(description: "testAscendingSorting")
        
        let model = InboxViewControllerViewModel()
        model.comparator = IterableInboxViewController.DefaultComparator.ascending
        
        let fetcher = MockInAppFetcher()
        
        IterableAPI.initializeForTesting(
            inAppFetcher: fetcher
        )
        
        let date1 = Date()
        let date2 = date1.addingTimeInterval(5.0)
        let messages = [
            IterableInAppMessage(messageId: "message1",
                                 campaignId: "",
                                 trigger: IterableInAppTrigger(dict: [JsonKey.InApp.type: "never"]),
                                 createdAt: date1,
                                 content: IterableHtmlInAppContent(edgeInsets: .zero, backgroundAlpha: 0.0, html: ""),
                                 saveToInbox: true,
                                 inboxMetadata: nil,
                                 customPayload: nil),
            IterableInAppMessage(messageId: "message2",
                                 campaignId: "",
                                 trigger: IterableInAppTrigger(dict: [JsonKey.InApp.type: "never"]),
                                 createdAt: date2,
                                 content: IterableHtmlInAppContent(edgeInsets: .zero, backgroundAlpha: 0.0, html: ""),
                                 saveToInbox: true,
                                 inboxMetadata: nil,
                                 customPayload: nil),
        ]
        fetcher.mockMessagesAvailableFromServer(messages: messages)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            model.beganUpdates()
            XCTAssertEqual(model.message(atIndexPath: IndexPath(row: 0, section: 0)).iterableMessage.messageId, "message1")
            XCTAssertEqual(model.message(atIndexPath: IndexPath(row: 1, section: 0)).iterableMessage.messageId, "message2")
            expectation1.fulfill()
        }
        
        wait(for: [expectation1], timeout: testExpectationTimeout)
    }
    
    func testNoSortingIsDescending() {
        let expectation1 = expectation(description: "testNoSorting")
        
        let model = InboxViewControllerViewModel()
        
        let fetcher = MockInAppFetcher()
        
        IterableAPI.initializeForTesting(
            inAppFetcher: fetcher
        )
        
        let date1 = Date()
        let date2 = date1.addingTimeInterval(5.0)
        let messages = [
            IterableInAppMessage(messageId: "message1",
                                 campaignId: "",
                                 trigger: IterableInAppTrigger(dict: [JsonKey.InApp.type: "never"]),
                                 createdAt: date1,
                                 content: IterableHtmlInAppContent(edgeInsets: .zero, backgroundAlpha: 0.0, html: ""),
                                 saveToInbox: true,
                                 inboxMetadata: nil,
                                 customPayload: nil),
            IterableInAppMessage(messageId: "message2",
                                 campaignId: "",
                                 trigger: IterableInAppTrigger(dict: [JsonKey.InApp.type: "never"]),
                                 createdAt: date2,
                                 content: IterableHtmlInAppContent(edgeInsets: .zero, backgroundAlpha: 0.0, html: ""),
                                 saveToInbox: true,
                                 inboxMetadata: nil,
                                 customPayload: nil),
        ]
        fetcher.mockMessagesAvailableFromServer(messages: messages)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            model.beganUpdates()
            XCTAssertEqual(model.message(atIndexPath: IndexPath(row: 0, section: 0)).iterableMessage.messageId, "message2")
            XCTAssertEqual(model.message(atIndexPath: IndexPath(row: 1, section: 0)).iterableMessage.messageId, "message1")
            expectation1.fulfill()
        }
        
        wait(for: [expectation1], timeout: testExpectationTimeout)
    }
    
    func testWithNoFiltering() {
        let expectation1 = expectation(description: "testWithNoFiltering")
        
        let model = InboxViewControllerViewModel()
        
        let fetcher = MockInAppFetcher()
        
        IterableAPI.initializeForTesting(
            inAppFetcher: fetcher
        )
        
        let date1 = Date()
        let date2 = date1.addingTimeInterval(5.0)
        let messages = [
            IterableInAppMessage(messageId: "message1",
                                 campaignId: "",
                                 trigger: IterableInAppTrigger(dict: [JsonKey.InApp.type: "never"]),
                                 createdAt: date1,
                                 content: IterableHtmlInAppContent(edgeInsets: .zero, backgroundAlpha: 0.0, html: ""),
                                 saveToInbox: true,
                                 inboxMetadata: nil,
                                 customPayload: nil),
            IterableInAppMessage(messageId: "message2",
                                 campaignId: "",
                                 trigger: IterableInAppTrigger(dict: [JsonKey.InApp.type: "never"]),
                                 createdAt: date2,
                                 content: IterableHtmlInAppContent(edgeInsets: .zero, backgroundAlpha: 0.0, html: ""),
                                 saveToInbox: true,
                                 inboxMetadata: nil,
                                 customPayload: nil),
        ]
        fetcher.mockMessagesAvailableFromServer(messages: messages)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            model.beganUpdates()
            XCTAssertEqual(model.numRows(in: 0), 2)
            XCTAssertEqual(model.message(atIndexPath: IndexPath(row: 0, section: 0)).iterableMessage.messageId, "message2")
            XCTAssertEqual(model.message(atIndexPath: IndexPath(row: 1, section: 0)).iterableMessage.messageId, "message1")
            expectation1.fulfill()
        }
        
        wait(for: [expectation1], timeout: testExpectationTimeout)
    }
    
    func testCustomFiltering() {
        let expectation1 = expectation(description: "testCustomFiltering")
        
        let model = InboxViewControllerViewModel()
        model.filter = { $0.messageId == "message1" }
        
        let fetcher = MockInAppFetcher()
        
        IterableAPI.initializeForTesting(
            inAppFetcher: fetcher
        )
        
        let date1 = Date()
        let date2 = date1.addingTimeInterval(5.0)
        let messages = [
            IterableInAppMessage(messageId: "message1",
                                 campaignId: "",
                                 trigger: IterableInAppTrigger(dict: [JsonKey.InApp.type: "never"]),
                                 createdAt: date1,
                                 content: IterableHtmlInAppContent(edgeInsets: .zero, backgroundAlpha: 0.0, html: ""),
                                 saveToInbox: true,
                                 inboxMetadata: nil,
                                 customPayload: nil),
            IterableInAppMessage(messageId: "message2",
                                 campaignId: "",
                                 trigger: IterableInAppTrigger(dict: [JsonKey.InApp.type: "never"]),
                                 createdAt: date2,
                                 content: IterableHtmlInAppContent(edgeInsets: .zero, backgroundAlpha: 0.0, html: ""),
                                 saveToInbox: true,
                                 inboxMetadata: nil,
                                 customPayload: nil),
        ]
        fetcher.mockMessagesAvailableFromServer(messages: messages)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            model.beganUpdates()
            XCTAssertEqual(model.numRows(in: 0), 1)
            XCTAssertEqual(model.message(atIndexPath: IndexPath(row: 0, section: 0)).iterableMessage.messageId, "message1")
            expectation1.fulfill()
        }
        
        wait(for: [expectation1], timeout: testExpectationTimeout)
    }
    
    func testSampleFilter() {
        let expectation1 = expectation(description: "testSampleFilter")
        
        let model = InboxViewControllerViewModel()
        model.filter = IterableInboxViewController.DefaultFilter.usingCustomPayloadMessageType(in: "promotional")
        
        let fetcher = MockInAppFetcher()
        
        IterableAPI.initializeForTesting(
            inAppFetcher: fetcher
        )
        
        let date1 = Date()
        let date2 = date1.addingTimeInterval(5.0)
        let messages = [
            IterableInAppMessage(messageId: "message1",
                                 campaignId: "",
                                 trigger: IterableInAppTrigger(dict: [JsonKey.InApp.type: "never"]),
                                 createdAt: date1,
                                 content: IterableHtmlInAppContent(edgeInsets: .zero, backgroundAlpha: 0.0, html: ""),
                                 saveToInbox: true,
                                 inboxMetadata: nil,
                                 customPayload: ["messageType": "transactional"]),
            IterableInAppMessage(messageId: "message2",
                                 campaignId: "",
                                 trigger: IterableInAppTrigger(dict: [JsonKey.InApp.type: "never"]),
                                 createdAt: date2,
                                 content: IterableHtmlInAppContent(edgeInsets: .zero, backgroundAlpha: 0.0, html: ""),
                                 saveToInbox: true,
                                 inboxMetadata: nil,
                                 customPayload: ["messageType": "promotional"]),
        ]
        fetcher.mockMessagesAvailableFromServer(messages: messages)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            model.beganUpdates()
            XCTAssertEqual(model.numRows(in: 0), 1)
            XCTAssertEqual(model.message(atIndexPath: IndexPath(row: 0, section: 0)).iterableMessage.messageId, "message2")
            expectation1.fulfill()
        }
        
        wait(for: [expectation1], timeout: testExpectationTimeout)
    }
}