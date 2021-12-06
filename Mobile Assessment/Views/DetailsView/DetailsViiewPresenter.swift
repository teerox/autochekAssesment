//
//  DetailsViiewPresenter.swift
//  Mobile Assessment
//
//  Created by Anthony Odu on 12/4/21.
//

import Foundation
import RxCocoa
import RxSwift

final class DetailsViewPresenter {
    
    // MARK: Properties
    private var webService: BaseNetworkService?
    let loading: PublishSubject<Bool> = PublishSubject()
    let error : PublishSubject<RequestError> = PublishSubject()
    let getVehicleDetails: PublishSubject<VehicleDetails?> = PublishSubject()

    init(
        webService: BaseNetworkService = BaseNetworkService()
    ) {
        self.webService = webService
    }
    
    deinit {
        webService = nil
    }
    
    func fetchAllVehicles(carId:String) {
        self.loading.onNext(true)
        self.webService?.requestData(url: WebConfig.vehicleDetails.rawValue + carId, method: .get, requestObject: Optional<String>.none, responseType: VehicleDetails.self, completion: { [weak self] result in
            guard let self = self else { return }
            self.loading.onNext(false)
            self.handleVehicleDetails(data: result)
        })
    }
    
    private func handleVehicleDetails<T>(data: RequestResult<T>) where T : Decodable, T : Encodable {
        switch data {
        case .success(let object):
            if let obj = object as? VehicleDetails {
                self.getVehicleDetails.onNext(obj)
            } else {
                self.getVehicleDetails.onNext(nil)
            }
        case .failure(let error):
            self.error.onNext(error)
        }
    }
    
}
