//
//  NetworkTest.swift
//  Mobile AssessmentTests
//
//  Created by Anthony Odu on 12/6/21.
//

import XCTest
import Foundation
@testable import Mobile_Assessment
import RxSwift

class NetworkTest: XCTestCase {
    
    // custom urlsession for mock network calls
    var baseWebProtocol: BaseWebProtocol!
    var correct = 0
    
    override func setUpWithError() throws {
        // Set url session for mock networking
        baseWebProtocol = BaseNetworkService()
    }
    
    func testHomeViewPresenterForAllBrands() throws {
        //  API. Injected with custom url session for mocking
        let data = HomeViewPresenter(webService: baseWebProtocol as! BaseNetworkService)
        // Set expectation. Used to test async code.
        let expectation = XCTestExpectation(description: "response")
        // Make mock network request
        data.fetchAllBrands()
        
        _ = data.getmakes.subscribe(onNext: { result in
            XCTAssertTrue(!result.isEmpty)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }
    
    
    func testHomeViewPresenterForAllVehicles() throws {
        //  API. Injected with custom url session for mocking
        let data = HomeViewPresenter(webService: baseWebProtocol as! BaseNetworkService)
        // Set expectation. Used to test async code.
        let expectation = XCTestExpectation(description: "response")
        // Make mock network request
        data.fetchAllVehicles()
        
        _ = data.getVehicle.subscribe(onNext: { result in
            XCTAssertTrue(!result.isEmpty)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }
   
    func testDetailsViewPresenterForVehicleWrongId() throws {
        //  API. Injected with custom url session for mocking
        let data = DetailsViewPresenter(webService: baseWebProtocol as! BaseNetworkService)
        // Set expectation. Used to test async code.
        let expectation = XCTestExpectation(description: "response")
        // Make mock network request
        data.fetchAllVehicles(carId: "7yndB8AT1")
        
        _ = data.getVehicleDetails.subscribe(onNext: {[weak self] result in
            if result == nil {
                self?.correct = 0
            } else {
                self?.correct = 1
            }
            XCTAssertEqual(self?.correct, 1)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }
    
    func testDetailsViewPresenterForVehicleCorrect() throws {
        //  API. Injected with custom url session for mocking
        let data = DetailsViewPresenter(webService: baseWebProtocol as! BaseNetworkService)
        // Set expectation. Used to test async code.
        let expectation = XCTestExpectation(description: "response")
        // Make mock network request
        data.fetchAllVehicles(carId: "6UCSeT3pn")
        
        _ = data.getVehicleDetails.subscribe(onNext: { [weak self] result in
            if result == nil {
                self?.correct = 0
            } else {
                self?.correct = 1
            }
            XCTAssertEqual(self?.correct, 1)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }
    
}
