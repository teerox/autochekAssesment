//
//  VehicleDetails.swift
//  Mobile Assessment
//
//  Created by Anthony Odu on 12/4/21.
//

import Foundation
// MARK: - Welcome
struct VehicleDetails: Codable {
    let id: String?
    let year: Int?
    let insured: Bool?
    let mileage: Int?
    let vin: String?
    let marketplacePrice: Double?
    let marketplaceVisible: Bool?
    let marketplaceVisibleDate: String?
    let isFeatured: Bool?
    let imageURL: String?
    let model: BodyType?
    let state, country, ownerType, transmission: String?
    let fuelType, sellingCondition: String?
    let bodyType: BodyType?
    let city: String?
    let marketplaceOldPrice: Int?
    let createdAt, updatedAt, mileageUnit: String?
    let hasWarranty, hasFinancing: Bool?
    let interiorColor, exteriorColor, engineType: String?
    let gradeScore: Double?
    let installment: Int?
    let depositReceived: Bool?
    let loanValue: Int?
    let websiteURL: String?
    let stats: Stats?
    let sold, hasThreeDImage: Bool?
    let inspectorDetails: InspectorDetails?
    let carName: String?
    let financingSettings: FinancingSettings?

    enum CodingKeys: String, CodingKey {
        case id, year, insured, mileage, vin, marketplacePrice, marketplaceVisible, marketplaceVisibleDate, isFeatured
        case imageURL = "imageUrl"
        case model, state, country, ownerType, transmission, fuelType, sellingCondition, bodyType, city, marketplaceOldPrice, createdAt, updatedAt, mileageUnit, hasWarranty, hasFinancing, interiorColor, exteriorColor, engineType, gradeScore, installment, depositReceived, loanValue
        case websiteURL = "websiteUrl"
        case stats, sold, hasThreeDImage, inspectorDetails, carName, financingSettings
    }
}
// MARK: - BodyType
struct BodyType: Codable {
    let id: Int?
    let name: String?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "imageUrl"
    }
}

// MARK: - FinancingSettings
struct FinancingSettings: Codable {
    let loanCalculator: LoanCalculator?
}

// MARK: - LoanCalculator
struct LoanCalculator: Codable {
    let loanPercentage: Double?
    let ranges: Ranges?
    let defaultValues: DefaultValues?
}

// MARK: - DefaultValues
struct DefaultValues: Codable {
    let interestRate, downPayment: Double?
    let tenure: Int?
}

// MARK: - Ranges
struct Ranges: Codable {
    let minInterestRate, maxInterestRate, minDownPayment, maxDownPayment: Double?
    let tenure: Int?
}

// MARK: - InspectorDetails
struct InspectorDetails: Codable {
    let inspectedMakes: [InspectedMake]
    let inspectorFullName, workshopName: String?
    let totalInspection: Int?
}

// MARK: - InspectedMake
struct InspectedMake: Codable {
    let count: Int?
    let name: String?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case count, name
        case imageURL = "imageUrl"
    }
}

