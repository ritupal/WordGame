//
//  HomeInteractorTest.swift
//  WordGameTests
//
//  Created by Kumari Ritu Pal on 02/08/22.
//
@testable import WordGame
import XCTest

class HomeInteractorTest: XCTestCase {
    
    // MARK: Subject under test
    var sut: HomeInteractor!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupHomeInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupHomeInteractor()
    {
        sut = HomeInteractor()
    }
    
    // MARK: Test doubles
    
    class HomePresentationLogicSpy: HomePresentationLogic {
        var loadTransalationPairCalled = false
        var onEndGameCalled = false
        var onQuitGameCalled = false
        var expectation: XCTestExpectation?
        
        func loadTranslationPair(word: WordsModel, correctAttempts: Int, wrongAttempts: Int) {
            loadTransalationPairCalled = true
            expectation?.fulfill()
        }
        
        func onEndGame(score: Int) {
            onEndGameCalled = true
            expectation?.fulfill()
        }
        
        func onQuitGame() {
            onQuitGameCalled = true
            expectation?.fulfill()
        }
    }
    
    // MARK: Tests
    func testFetchAllWordsSucceed() {
        // Given
        let spy = HomePresentationLogicSpy()
        spy.expectation = expectation(description: "fetching words from file")
        sut.presenter = spy
        
        // When
        sut.fetchWords()
        
        // Wait
        waitForExpectations(timeout: 1, handler: nil)
        
        // Then
        XCTAssertTrue(spy.loadTransalationPairCalled, "fetchwords should ask the presenter to format the result of the words if some of their arrays are populated")
    }
    
    func testEndGame() {
        // Given
        let spy = HomePresentationLogicSpy()
        sut.presenter = spy
        
        // When
        sut.endGame()
        
        // Then
        XCTAssertTrue(spy.onEndGameCalled, "interactor should ask the presenter to end the game")
    }
    
    func testQuitGame() {
        // Given
        let spy = HomePresentationLogicSpy()
        sut.presenter = spy
        
        // When
        sut.quitGame()

        // Then
        XCTAssertTrue(spy.onQuitGameCalled, "interactor should ask the presenter to quit the game")
    }
    
    func testCorrectTransalation() {
        // Given
        let spy = HomePresentationLogicSpy()
        sut.presenter = spy
        let infoModel = HomeInfoViewModel.init(engText: "class", spText: "curso", correctAttempts: 1, wrongAttempts: 0)
        let viewModel = HomeViewModel.init(homeInfoVM: infoModel)
        
        // When
        sut.fetchWords()
        sut.checkTransaltion(viewModel, isCorrect: true)
        // Then
        XCTAssertEqual(sut.correctAttempts, 1, "correct Attempts should be 1")
    }
    
    func testWrongTransalation() {
        // Given
        let spy = HomePresentationLogicSpy()
        sut.presenter = spy
        let infoModel = HomeInfoViewModel.init(engText: "class", spText: "cursol", correctAttempts: 0, wrongAttempts: 1)
        let viewModel = HomeViewModel.init(homeInfoVM: infoModel)
        
        // When
        sut.fetchWords()
        sut.checkTransaltion(viewModel, isCorrect: true)
        // Then
        XCTAssertEqual(sut.wrongAttempts, 1, "Wrong Attempts should be 1")
    }
    
    func testRestartGame() {
        // Given
        let spy = HomePresentationLogicSpy()
        sut.presenter = spy

        // When
        sut.fetchWords()
        sut.restartGame()

        // Then
        XCTAssertEqual(sut.wrongAttempts, 0, "Wrong Attempts should be 0")
        XCTAssertEqual(sut.correctAttempts, 0, "correct Attempts should be 0")
    }
}
