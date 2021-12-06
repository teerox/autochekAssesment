//
//  WebConfig.swift
//  Mobile Assessment
//
//  Created by Anthony Odu on 12/4/21.
//

import Foundation
/// API url configuration
/// This defines the configuration sent to base web config URL paramter read `BaseWebProtol`
/// - Note: Each URL should be group based on features,
public enum WebConfig:String {
    case allmake = "/v1/inventory/make?popular=true"
    case allvehicle = "/v1/inventory/car/search"
    case vehicleDetails = "/v1/inventory/car/"
    case vehicleMedia = "/v1/inventory/car_media"
}
