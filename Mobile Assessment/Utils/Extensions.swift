//
//  Extensions.swift
//  Mobile Assessment
//
//  Created by Anthony Odu on 12/5/21.
//

import Foundation

public extension Double {
    var delimiter: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let groupingSeparator = ","
        // formatter.positiveFormat = "###,###"
        // formatter.negativeFormat = "-###,###"
        numberFormatter.groupingSeparator = groupingSeparator
        return "\u{20A6}\(numberFormatter.string(from: NSNumber(value: self)) ?? "0")"
    }
}
