//
//  CustomViews.swift
//  Mobile Assessment
//
//  Created by Anthony Odu on 12/5/21.
//

import Foundation
import UIKit

class RoundedImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        let radius = self.frame.height/2.0
        layer.cornerRadius = radius
        clipsToBounds = true 
    }

}
