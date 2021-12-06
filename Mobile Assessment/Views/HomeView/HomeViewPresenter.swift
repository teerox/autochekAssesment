//
//  HomeViewPresenter.swift
//  Mobile Assessment
//
//  Created by Anthony Odu on 12/4/21.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewPresenter {
    
    // MARK: Properties
    private var webService: BaseNetworkService?
    let loading: PublishSubject<Bool> = PublishSubject()
    let error : PublishSubject<RequestError> = PublishSubject()
    let getmakes: PublishSubject<[MakeList]> = PublishSubject()
    let getVehicle: PublishSubject<[AllVehicles]> = PublishSubject()

    init(
        webService: BaseNetworkService = BaseNetworkService()
    ) {
        self.webService = webService
    }
    
    deinit {
        webService = nil
    }
    
    func fetchAllVehicles() {
        self.loading.onNext(true)
        self.webService?.requestData(url: WebConfig.allvehicle.rawValue, method: .get, requestObject: Optional<String>.none, responseType: Vehicles.self, completion: { [weak self] result in
            guard let self = self else { return }
            self.loading.onNext(false)
            
            self.handleAllVehicle(data: result)
        })
    }
    
    func fetchAllBrands() {
        self.loading.onNext(true)
        self.webService?.requestData(url: WebConfig.allmake.rawValue, method: .get, requestObject: Optional<String>.none, responseType: Makes.self, completion: { [weak self] result in
            guard let self = self else { return }
            self.loading.onNext(false)
            self.handleAllMakes(data: result)
        })
    }
    
    private func handleAllMakes<T>(data: RequestResult<T>) where T : Decodable, T : Encodable {
        switch data {
        case .success(let object):
            if let obj = object as? Makes {
                self.getmakes.onNext(obj.makeList)
            } else {
                self.getmakes.onNext([])
            }
        case .failure(let error):
            self.getmakes.onNext([])
            self.error.onNext(error)
        }
    }
    
    private func handleAllVehicle<T>(data: RequestResult<T>) where T : Decodable, T : Encodable {
        switch data {
        case .success(let object):
            if let obj = object as? Vehicles {
                self.getVehicle.onNext(obj.result)
            } else {
                self.getVehicle.onNext([])
            }
        case .failure(let error):
            self.getVehicle.onNext([])
            self.error.onNext(error)
        }
    }
}
