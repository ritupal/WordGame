//
//  HomePresenterTest.swift
//  WordGameTests
//
//  Created by Kumari Ritu Pal on 02/08/22.
//

@testable import WordGame
import XCTest

class HomePresenterTests: XCTestCase
{
    // MARK: Subject under test
    var sut: HomePresenter!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupHomePresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupHomePresenter() {
        sut = HomePresenter()
    }
    
    // MARK: Test doubles
    
    class HomeDisplayLogicSpy: HomeDisplayLogic {
        var correctAttempt = 0
        var loadLanguageWordCalled = false
        var endGameCalled = false
        var closeApp = false
        
        func loadLanguageWord(_ viewModel: HomeViewModel) {
            correctAttempt = viewModel.homeInfoVM.correctAttempts
            loadLanguageWordCalled = true
        }
        
        func endGameWithScore(_ score: Int) {
            endGameCalled = true
        }
        
        func closeAppOnGameQuit() {
            closeApp = true
            
        }
    }
    
    // MARK: Tests
    
    func testOnGetWordsForHomeSucceed() {
        // Given
        let spy = HomeDisplayLogicSpy()
        sut.viewController = spy
        
        // When
        let wordResponseModel: WordsModel = Bundle.main.decode(FileName.mockWord.rawValue)
        sut.loadTranslationPair(word: wordResponseModel, correctAttempts: 1, wrongAttempts: 1)
        
        //then
        XCTAssertEqual(spy.correctAttempt, 1, "correct attempts after load should be one")
    }
    
    func testEndGame() {
        // Given
        let spy = HomeDisplayLogicSpy()
        sut.viewController = spy
        
        //when
        sut.onEndGame(score: 1)
        XCTAssertTrue(spy.endGameCalled, "EndGame() should ask the viewcontroller to show the alert ")
    }
    
    func testQuitGame() {
        // Given
        let spy = HomeDisplayLogicSpy()
        sut.viewController = spy
        
        //when
        sut.onQuitGame()
        XCTAssertTrue(spy.closeApp, "quitGame() should exit the app ")
    }
    
}
