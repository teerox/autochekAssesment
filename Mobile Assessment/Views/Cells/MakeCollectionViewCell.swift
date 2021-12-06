//
//  MakeCollectionViewCell.swift
//  Mobile Assessment
//
//  Created by Anthony Odu on 12/5/21.
//

import UIKit
import SDWebImage

class MakeCollectionViewCell: UICollectionViewCell {
    static var identifier = "CustomeMakeCollectionViewCell"
    
    private let myImageView: RoundedImageView = {
        let imgView = RoundedImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imgView.backgroundColor = UIColor(named: "cellImageColor")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    private let myLabel: UILabel = {
        let labText = UILabel()
        labText.textAlignment = .center
        labText.font = UIFont.systemFont(ofSize: 14)
        return labText
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 10
        sv.alignment = .center
        sv.addArrangedSubview(myImageView)
        sv.addArrangedSubview(myLabel)
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(stackView)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstrains()
    }
    
    func setupView(value:MakeList) {
        myLabel.text = value.name
        myImageView.sd_setImage(with: URL(string: value.imageURL), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    func setupView2(value:InspectedMake) {
        myLabel.text = value.name
        myImageView.sd_setImage(with: URL(string: value.imageURL ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    func setupConstrains() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
    }
}
