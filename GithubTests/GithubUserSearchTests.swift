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
        let (sut, doubles) = makeSUT(addRightParams: nil)
        
        //When
        sut.validUsername(username: doubles.emptyUsername)
        
        //Then
        XCTAssertEqual(doubles.presenterSpy.messages, [.showEmptyUserAlert])
    }
    
    func testEmptyUserData() {
        // Given
        let (sut, doubles) = makeSUT(addRightParams: nil)
        
        //When
        sut.validUsername(username: doubles.userNotFound)
        
        //Then
        XCTAssertEqual(doubles.presenterSpy.messages, [])
        XCTAssertNotNil(doubles.emptyNetworkSessionMock.completion)
        
        doubles.emptyNetworkSessionMock.completion?()
        
        //Then
        XCTAssertEqual(doubles.presenterSpy.messages, [.showServiceError])
    }
    
    func testWrongUserData() {
        // Given
        let (sut, doubles) = makeSUT(addRightParams: false)
        
        //When
        sut.validUsername(username: doubles.userNotFound)
        
        //Then
        XCTAssertEqual(doubles.presenterSpy.messages, [])
        XCTAssertNotNil(doubles.wrongParamsNetworkSessionMock.completion)
        
        doubles.wrongParamsNetworkSessionMock.completion?()
        
        //Then
        XCTAssertEqual(doubles.presenterSpy.messages, [.showServiceError])
    }
    
    func testUserFound() {
        // Given
        let (sut, doubles) = makeSUT(addRightParams: true)
        
        //When
        sut.validUsername(username: doubles.userNotFound)
        
        //Then
        XCTAssertEqual(doubles.presenterSpy.messages, [])
        XCTAssertNotNil(doubles.rightParamsNetworkSessionMock.completion)
        
        //And
        doubles.rightParamsNetworkSessionMock.completion?()
        doubles.rightParamsNetworkSessionMock.completion?()
        doubles.rightParamsNetworkSessionMock.completion?()
        
        //Then
        XCTAssertEqual(doubles.presenterSpy.messages, [.navigateToUserInfo(data: doubles.userInfo, imageData: doubles.data, repos: [doubles.repos])])
    }
    
    
    // TO DO - testar se o endpoint e os params estao corretos
    // testar se o contrato é válido (retorno)
    // garantir que esteja chamando na ordem certa
}

private extension GithubUserSearchTests {
    
    final class Doubles {
        let presenterSpy = HomePresenterProtocolSpy()
        
        let emptyUsername = ""
        let userNotFound = "ZZZZZZZZZ"
        let user = "MatheusGPrada"
        
        let userInfo = UserInfo(
            avatar_url: URL(string: "https://example.com/avatar_url")!,
            url: URL(string: "https://example.com/user")!,
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
        
        let userInfoJSON = """
        {
            "avatar_url": "https://example.com/avatar_url",
            "url": "https://example.com/user",
            "company": "Example Company",
            "location": "Example Location",
            "bio": "Example Bio",
            "name": "Example Name",
            "repos_url": "https://example.com/repos"
        }
        """
        lazy var userInfoData = userInfoJSON.data(using: .utf8)
        lazy var userInfoDataOptional: Data? = userInfoData
        
        var optionalData: Data? = Data()
        var imageData = Data()
        
        var reposJSON = """
        [
            {
                "name": "Example Repo",
                "html_url": "https://github.com/example/repo",
                "description": "This is an example repository.",
                "language": "Swift",
                "updated_at": "2023-10-26T15"
            }
        ]
        """
        lazy var reposData = reposJSON.data(using: .utf8)
        lazy var reposDataOptional: Data? = reposData
        
        // TO DO - remove networkSessionMock from doubles
        lazy var emptyNetworkSessionMock = NetworkSessionMock()
        lazy var wrongParamsNetworkSessionMock = NetworkSessionMock(data: optionalData,response: nil, error: nil)
        lazy var rightParamsNetworkSessionMock = NetworkSessionMock(data: userInfoDataOptional,response: nil, error: nil, imageData: imageData, reposData: reposDataOptional)
    }
    
    func makeSUT(addRightParams: Bool?) -> (HomeInteractor, Doubles){
        let doubles = Doubles()
        let networkParams = addRightParams == nil ? doubles.emptyNetworkSessionMock : addRightParams! ? doubles.rightParamsNetworkSessionMock : doubles.wrongParamsNetworkSessionMock
        
        // TO DO - REFACTOR
        let userInfoService = UserInfoService(networkSession: networkParams)
        let userImageService = UserInfoService(networkSession: networkParams)
        let userReposService = UserInfoService(networkSession: networkParams)
        
        let sut = HomeInteractor(presenter: doubles.presenterSpy, networkSession: networkParams, userInfoService: userInfoService, userImageService: userImageService as! UserImageServiceProtocol, userReposService: userReposService as! UserReposServiceProtocol)
        
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
        
        private(set) var messages: [Messages] = []
        
        func showEmptyUserAlert(){
            messages.append(.showEmptyUserAlert)
        }
        
        func showUserNotFoundAlert() {
            messages.append(.showUserNotFoundAlert)
        }
        
        func showUserInfo(data: UserInfo, imageData: Data, repos: [Repos]) {
            messages.append(.navigateToUserInfo(data: data, imageData: imageData, repos: repos))
        }
        
        func showServiceError(_ error: Error) {
            //TO DO - VALIDATE ERROR MESSAGE
            messages.append(.showServiceError)
        }
    }
}

class NetworkSessionMock: NetworkSession {
    
    let data: Data?
    let response: URLResponse?
    let error: Error?
    
    let imageData: Data?
    
    let reposData: Data?
    
    var completion: (() -> Void)?
    
    init(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil, imageData: Data? = nil, reposData: Data? = nil) {
        self.data = data
        self.response = response
        self.error = error
        self.imageData = imageData
        self.reposData = reposData
    }
    
    func dataTask(
        with url: URL,
        completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {

        switch url {
        case URL(string: "https://example.com/avatar_url"):
            completion = { [weak self] in
                completionHandler(self?.imageData, self?.response, self?.error)
            }
        case URL(string: "https://example.com/repos"):
            completion = { [weak self] in
                completionHandler(self?.reposData, self?.response, self?.error)
            }
        default:
            completion = { [weak self] in
                completionHandler(self?.data, self?.response, self?.error)
            }
        }
        
        return MockURLSessionDataTask()
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    override func resume() {
    }
    
    override func cancel() {
    }
}




