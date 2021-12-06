//
//  Vehicles.swift
//  Mobile Assessment
//
//  Created by Anthony Odu on 12/4/21.
//

import Foundation

// MARK: - Welcome
struct Makes: Codable {
    let makeList: [MakeList]
    let pagination: Pagination
}

// MARK: - MakeList
struct MakeList: Codable {
    let id: Int
    let name: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "imageUrl"
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    let total, currentPage, pageSize: Int
}

// MARK: - Welcome
struct Vehicles: Codable {
    let result: [AllVehicles]
    let pagination: Pagination
}

// MARK: - AllVehicles
struct AllVehicles: Codable {
    let id, title: String?
    let imageURL: String?
    let year: Int?
    let city: String?
    let state: String?
    let gradeScore: Double?
    let sellingCondition: String?
    let hasWarranty: Bool?
    let marketplacePrice, marketplaceOldPrice: Double?
    let hasFinancing: Bool?
    let mileage: Int?
    let mileageUnit: String?
    let installment: Int?
    let depositReceived: Bool?
    let loanValue: Int?
    let websiteURL: String?
    let stats: Stats?
    let bodyTypeID: String?
    let sold, hasThreeDImage: Bool?

    enum CodingKeys: String, CodingKey {
        case id, title
        case imageURL = "imageUrl"
        case year, city, state, gradeScore, sellingCondition, hasWarranty, marketplacePrice, marketplaceOldPrice, hasFinancing, mileage, mileageUnit, installment, depositReceived, loanValue
        case websiteURL = "websiteUrl"
        case stats
        case bodyTypeID = "bodyTypeId"
        case sold, hasThreeDImage
    }
}
// MARK: - Stats
struct Stats: Codable {
    let webViewCount, webViewerCount, interestCount, testDriveCount: Int
    let appViewCount, appViewerCount, processedLoanCount: Int
}
