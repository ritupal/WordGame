//
//  HomeViewControllerTest.swift
//  WordGameTests
//
//  Created by Kumari Ritu Pal on 02/08/22.
//
@testable import WordGame
import XCTest

class HomeViewControllerTest: XCTestCase {
    let interactor = HomeBusinessLogicMock()
    // MARK: Subject under test
    var sut: HomeViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupHomeViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupHomeViewController()
    {
        sut = HomeViewController.instantiate(HomeViewController.self)
    }
    
    func loadView()
    {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    
    class HomeBusinessLogicMock: HomeBuisnessLogic
    {
        private(set) var fetchWordsOnLoadCalled = false
        
        func fetchWords() {
            fetchWordsOnLoadCalled = true
        }
        
        private(set) var onCheckTransalationCalled = false
        func checkTransaltion(_ vm: HomeViewModel?, isCorrect: Bool) {
            
            onCheckTransalationCalled = true
        }

        private(set) var onEndGameCalled = false
        
        func endGame() {
            onEndGameCalled = true
        }
        
        private(set) var onRestartGameCalled = false
        func restartGame() {
            onRestartGameCalled = true
        }
        private(set) var onQuitGameCalled = false
        func quitGame() {
            onQuitGameCalled = true
        }
        
    }
    
    // MARK: Tests
    
    func testShouldFetchWordsWhenIsLoaded() {
      // Given
      let mock = HomeBusinessLogicMock()

      sut.interactor = mock
      
      // When
      loadView()
      
      // Then
      XCTAssertTrue(mock.fetchWordsOnLoadCalled, "viewDidLoad() should ask the interactor to fetch Words")
    }
    
    func testDisplayWordPair() {
        // Given
        let infoModel = HomeInfoViewModel.init(engText: "class", spText: "curso", correctAttempts: 1, wrongAttempts: 0)
        let viewModel = HomeViewModel.init(homeInfoVM: infoModel)
        
        // When
        loadView()
        sut.loadLanguageWord(viewModel)
        
        // Then
        XCTAssertEqual(viewModel.homeInfoVM.correctAttempts, 1, "correct attempts should be 1")
    }
    
    func testEndGameWithMaxCorrectAttempts() {
        // Given
        let mock = HomeBusinessLogicMock()
        sut.interactor = mock
        let infoModel = HomeInfoViewModel.init(engText: "class", spText: "curso", correctAttempts: 15, wrongAttempts: 0)
        
        // When
        loadView()
        sut.endGame(vm: infoModel)
        
        //then
        XCTAssertTrue(mock.onEndGameCalled, "viewDidLoad() should ask the interactor to end game")
    }
    
    func testEndGameWithMaxWrongAttempts() {
        // Given
        let mock = HomeBusinessLogicMock()
        sut.interactor = mock
        let infoModel = HomeInfoViewModel.init(engText: "class", spText: "curso", correctAttempts: 1, wrongAttempts: 3)
        
        // When
        loadView()
        sut.endGame(vm: infoModel)
        
        //then
        XCTAssertTrue(mock.onEndGameCalled, "viewDidLoad() should ask the interactor to end game")
    }
    
    func testEndGameScore() {
        // Given
        let mock = HomeBusinessLogicMock()
        sut.interactor = mock
        
        // When
        loadView()
        sut.endGameWithScore(1)
        
        //then
        XCTAssertTrue(sut.presentedViewController is UIAlertController, "viewDidLoad() should ask the interactor to end game")
    }
}
