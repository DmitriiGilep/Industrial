//
//  CheckerServiceTests.swift
//  AuthorizationTests
//
//  Created by DmitriiG on 11.03.2023.
//

import Foundation
import XCTest

@testable import Industrial

class CheckerServiceTests: XCTestCase {
    
    override func setUpWithError() throws {
        let controller = LoginViewControllerStub()
        let checkerServiceTest = CheckerService()
        checkerServiceTest.controller = controller
        let login = "gilep@mail.ru"
        let password = "123456"
        let passwordEmpty = ""
    }
    
    func checkSignUPEmptyLogin() {
        let loginEmpty = ""
        let password = "123456"
        checkerServiceTest.checkCredentials(login: loginEmpty, password: password)
        XCTAssertEqual(controller.callAlertViewSignUpFailureCalled, true)
    }
    
    func checkSignUPEmptyPassword() {
        let login = "GGG"
        let passwordEmpty = ""
        checkerServiceTest.checkCredentials(login: login, password: passwordEmpty)
        XCTAssertEqual(controller.callAlertViewSignUpFailureCalled, true)
    }
    
    
}

class LoginViewControllerStub: CheckerServiceControllerProtocol {
    
    let callAlertViewSignUpFailureCalled = false
    let callAlertViewSignUpSuccessCalled = false
    let callAlertViewCredentialFailureCalled = false
    let goToProfilePageCalled = false
    
    func callAlertViewSignUpFailure() {
        callAlertViewSignUpFailureStatus = true
    }
    
    func callAlertViewSignUpSuccess() {
        callAlertViewSignUpSuccessCalled = true
    }
    func callAlertViewCredentialFailure() {
        callAlertViewCredentialFailureCalled = true
    }
    func goToProfilePage() {
        goToProfilePageCalled = true
    }
    
}
