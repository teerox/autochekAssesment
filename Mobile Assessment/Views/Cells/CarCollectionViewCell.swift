//
//  CarCollectionViewCell.swift
//  Mobile Assessment
//
//  Created by Anthony Odu on 12/5/21.
//

import UIKit

class CarCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "CustomeCarCollectionViewCell"
    
    private let nameLabel: UILabel = {
        let labText = UILabel()
        labText.textAlignment = .center
        labText.font = UIFont.boldSystemFont(ofSize: 20)
        return labText
    }()
    
    private let modelLabel: UILabel = {
        let labText = UILabel()
        labText.textAlignment = .center
        labText.font = UIFont.systemFont(ofSize: 14)
        return labText
    }()
    
    private let priceLabel: UILabel = {
        let labText = UILabel()
        labText.textAlignment = .center
        labText.font = UIFont.boldSystemFont(ofSize: 16)
        return labText
    }()
    
    private let rateLabel: UILabel = {
        let labText = UILabel()
        labText.textAlignment = .center
        labText.font = UIFont.systemFont(ofSize: 14)
        return labText
    }()
    
    lazy var xButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        button.imageEdgeInsets = UIEdgeInsets(top: 50.0, left: 50.0, bottom: 50.0, right: 50.0)
        return button
    }()
    
    private let loveImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imgView.image = UIImage(systemName: "heart.circle.fill")
        imgView.tintColor = .red
        imgView.contentMode = .scaleAspectFit
        let radius = imgView.frame.height/2.0
        imgView.layer.cornerRadius = radius
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private let starimage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imgView.image = UIImage(systemName: "star.fill")
        imgView.tintColor = .yellow
        imgView.contentMode = .scaleAspectFit
        let radius = imgView.frame.height/2.0
        imgView.layer.cornerRadius = radius
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private let carimage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 20
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .equalCentering
        sv.alignment = .center
        sv.addArrangedSubview(nameLabel)
        sv.addArrangedSubview(stackView2)
        return sv
    }()
    
    lazy var stackView2: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 10
        sv.distribution = .fill
        sv.alignment = .center
        sv.addArrangedSubview(starimage)
        sv.addArrangedSubview(rateLabel)
        return sv
    }()
    
    lazy var stackView3: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 5
        sv.alignment = .leading
        sv.addArrangedSubview(stackView)
        sv.addArrangedSubview(modelLabel)
        sv.addArrangedSubview(priceLabel)
        return sv
    }()
    
    private let carView: UIView = {
        let myCarView = UIView()
        myCarView.layer.cornerRadius = 20
        myCarView.layer.masksToBounds = true
        myCarView.backgroundColor = .white
        return myCarView
    }()
    
    private let carView2: UIView = {
        let myCarView = UIView()
        myCarView.backgroundColor = UIColor(named: "car-cell-color")
        myCarView.layer.cornerRadius = 20
        myCarView.layer.masksToBounds = true
        return myCarView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        carView.addSubview(stackView3)
        carView2.addSubview(carimage)
        carView2.addSubview(loveImage)
        carView.addSubview(xButton)
        contentView.addSubview(carView)
        contentView.addSubview(carView2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstrains()
    }
    
    func setupConstrains() {
        carView.translatesAutoresizingMaskIntoConstraints = false
        carView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        carView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        carView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        carView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50).isActive = true
        
        stackView3.translatesAutoresizingMaskIntoConstraints = false
        stackView3.bottomAnchor.constraint(equalTo: carView.bottomAnchor, constant: -10).isActive = true
        stackView.leftAnchor.constraint(equalTo: carView.leftAnchor, constant: 30).isActive = true
        stackView.rightAnchor.constraint(equalTo: carView.rightAnchor, constant: -30).isActive = true
        
        xButton.translatesAutoresizingMaskIntoConstraints = false
        xButton.bottomAnchor.constraint(equalTo: carView.bottomAnchor, constant: -10).isActive = true
        xButton.rightAnchor.constraint(equalTo: carView.rightAnchor, constant: -20).isActive = true
        
        carView2.translatesAutoresizingMaskIntoConstraints = false
        carView2.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -30).isActive = true
        carView2.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 40).isActive = true
        carView2.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -40).isActive = true
        carView2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100).isActive = true
        
        loveImage.translatesAutoresizingMaskIntoConstraints = false
        loveImage.topAnchor.constraint(equalTo: carView2.topAnchor, constant: 10).isActive = true
        loveImage.rightAnchor.constraint(equalTo: carView2.rightAnchor, constant: -10).isActive = true
        
        carimage.translatesAutoresizingMaskIntoConstraints = false
        carimage.widthAnchor.constraint(equalToConstant: 250).isActive = true
        carimage.heightAnchor.constraint(equalToConstant: 250).isActive = true
        carimage.centerXAnchor.constraint(equalTo: self.carView2.centerXAnchor).isActive = true
        carimage.centerYAnchor.constraint(equalTo: self.carView2.centerYAnchor).isActive = true
    }
    
    func setupView(value:AllVehicles) {
        nameLabel.text = value.title
        modelLabel.text = String(value.year ?? 0)
        priceLabel.text = value.marketplacePrice?.delimiter
        rateLabel.text = "5.0"
        carimage.sd_setImage(with: URL(string: value.imageURL ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
}
