//
//  GithubUserSearchTests.swift
//  GithubTests
//
//  Created by Matheus Prada on 08/11/23.
//

import XCTest
import Foundation
@testable import Github

final class GithubUserSearchTests: XCTestCase {
    
    func testEmptyUser() {
        // Given
        let (sut, doubles) = makeSUT()
        
        //When
        sut.validUsername(username: doubles.emptyUsername)
        
        //Then
        XCTAssertEqual(doubles.presenterSpy.messages, [.showEmptyUserAlert])
    }
    
    func testServiceError() {
        // Given
        let (sut, doubles) = makeSUT()

        //When
        sut.validUsername(username: doubles.userNotFound)
        
        //Then
        XCTAssertEqual(doubles.presenterSpy.messages, [])
        XCTAssertNotNil(doubles.networkSessionMock.completion)
        
        //And
        let expectation = self.expectation(description: "waiting service")
        expectation.expectedFulfillmentCount = 2
        
        doubles.presenterSpy.expectation = expectation
        doubles.networkSessionMock.expectation = expectation
        
        doubles.networkSessionMock.completion?()
        wait(for: [expectation], timeout: 1)
        
        //Then
        XCTAssertEqual(doubles.presenterSpy.messages, [.showServiceError])
    }
    
    
    // TO DO - testar se o endpoint e os params estao corretos
    // testar se o contrato é válido (retorno)
    // garantir que esteja chamando na ordem certa
    // criar implementacao do networksession que devolve o completionhandler na main thread (decorator pattern)
}

class MockURLSessionDataTask: URLSessionDataTask {
    override func resume() {
        // This is a no-op because it's a mock
    }
}

// TO DO - IMPROVE

class NetworkSessionMock: NetworkSession {
    let data: Data?
    let response: URLResponse?
    let error: Error?
    var completion: (() -> Void)?
    var expectation: XCTestExpectation?
    
    init(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    func dataTask(
        with url: URL,
        completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        completion = { [weak self] in
            self?.expectation?.fulfill()
            completionHandler(self?.data, self?.response, self?.error)
        }
        return MockURLSessionDataTask()
    }
}

private extension GithubUserSearchTests {
    final class Doubles {
        let presenterSpy = HomePresenterProtocolSpy()
        
        let emptyUsername = ""
        let userNotFound = "ZZZZZZZZZ"
        let user = "MatheusGPrada"
        
        let userInfo = UserInfo(
            avatar_url: URL(string: "https://example.com/avatar_url")!,
            url: URL(string: "https://example.com/url")!,
            company: "Example Company",
            location: "Example Location",
            bio: "Example Bio",
            name: "Example Name",
            repos_url: URL(string: "https://example.com/repos")!
        )
        let data = Data()
        let repos = Repos(
            name: "Example Repo",
            html_url: "https://github.com/example/repo",
            description: "This is an example repository.",
            language: "Swift",
            updated_at: "2023-10-26T15"
        )
        let optionalData: Data? = Data()
        
        // TO DO - adicionar os parametros na chamada
        lazy var networkSessionMock = NetworkSessionMock()
    }
    
    func makeSUT() -> (HomeInteractor, Doubles){
        let doubles = Doubles()
        let sut = HomeInteractor(presenter: doubles.presenterSpy, networkSession: doubles.networkSessionMock)
        
        //teste de memory leak
        addTeardownBlock { [weak sut, weak doubles] in
            XCTAssertNil(sut, "Potencial memory leak no SUT")
            XCTAssertNil(doubles, "Potencial memory leak no doubles")
        }
        
        return (sut, doubles)
    }
    
    final class HomePresenterProtocolSpy: HomePresenterProtocol {
        enum Messages: Equatable {
            case showEmptyUserAlert
            case showUserNotFoundAlert
            case navigateToUserInfo(data: UserInfo, imageData: Data, repos: [Repos])
            case showServiceError
        }
        // TO DO - quando passar de 2 params, deve ser struct
        var expectation: XCTestExpectation?
        
        private(set) var messages: [Messages] = []
        
        func showEmptyUserAlert(){
            messages.append(.showEmptyUserAlert)
        }
        
        func showUserNotFoundAlert() {
            messages.append(.showUserNotFoundAlert)
        }
        
        func navigateToUserInfo(data: UserInfo, imageData: Data, repos: [Repos]) {
            messages.append(.navigateToUserInfo(data: data, imageData: imageData, repos: repos))
        }
        
        func showServiceError() {
            expectation?.fulfill()
            messages.append(.showServiceError)
        }
    }
}




