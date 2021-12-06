//
//  DetailsViewController.swift
//  Mobile Assessment
//
//  Created by Anthony Odu on 12/5/21.
//

import UIKit
import RxCocoa
import RxSwift

class DetailsViewController: UIViewController {
    
    var myCollectionView:UICollectionView?
    private var allMakes: [InspectedMake] = []
    private var allMakesResponse: PublishSubject<[InspectedMake]>?
    private var presenter: DetailsViewPresenter?
    let disposeBag = DisposeBag()
    private var makeResponse: PublishSubject<VehicleDetails?>?
    public var id: String?
    
    lazy var scrollView : UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private var contentView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .equalCentering
        sv.alignment = .center
        sv.addArrangedSubview(topCollectionView)
        sv.addArrangedSubview(emptyStateMessage)
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
    
    private let carimage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 20
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    private let carView3: UIView = {
        let myCarView = UIView()
        myCarView.backgroundColor = .white
        myCarView.layer.cornerRadius = 20
        myCarView.layer.masksToBounds = true
        return myCarView
    }()
    
    lazy var topCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: (view.frame.size.width/4)-4, height: 100)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        myCollectionView?.showsHorizontalScrollIndicator = false
        myCollectionView?.showsVerticalScrollIndicator = false
        myCollectionView?.register(MakeCollectionViewCell.self, forCellWithReuseIdentifier: MakeCollectionViewCell.identifier)
        myCollectionView?.backgroundColor = .white
        myCollectionView?.delegate = self
        myCollectionView?.dataSource = self
        return myCollectionView ?? UICollectionView()
    }()
    
    lazy var emptyStateMessage: UILabel = {
        let messageLabel = UILabel()
        messageLabel.textColor = .darkGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.text = "Make Not Available"
        messageLabel.font = UIFont.boldSystemFont(ofSize: 20)
        messageLabel.sizeToFit()
        return messageLabel
    }()
    
        private let priceLabel: UILabel = {
            let labText = UILabel()
            labText.textAlignment = .center
            labText.font = UIFont.boldSystemFont(ofSize: 16)
            return labText
        }()
    
        private let fuelType: UILabel = {
            let labText = UILabel()
            labText.textAlignment = .center
            labText.font = UIFont.boldSystemFont(ofSize: 16)
            return labText
        }()
    
        private let sellingCondition: UILabel = {
            let labText = UILabel()
            labText.textAlignment = .center
            labText.font = UIFont.boldSystemFont(ofSize: 16)
            return labText
        }()

    private let priceLabelTop: UILabel = {
        let labText = UILabel()
        labText.textAlignment = .center
        labText.text = "Market Price"
        labText.font = UIFont.boldSystemFont(ofSize: 16)
        return labText
    }()

    private let fuelTypeTop: UILabel = {
        let labText = UILabel()
        labText.textAlignment = .center
        labText.text = "Fuel Type"
        labText.font = UIFont.boldSystemFont(ofSize: 16)
        return labText
    }()

    private let sellingConditionTop: UILabel = {
        let labText = UILabel()
        labText.textAlignment = .center
        labText.text = "Selling Condition"
        labText.font = UIFont.boldSystemFont(ofSize: 16)
        return labText
    }()
    
    private let available: UILabel = {
        let labText = UILabel()
        labText.textAlignment = .center
        labText.font = UIFont.boldSystemFont(ofSize: 25)
        return labText
    }()
    
        lazy var stackViewTop1: UIStackView = {
            let sv = UIStackView()
            sv.translatesAutoresizingMaskIntoConstraints = false
            sv.axis = .vertical
            sv.spacing = 10
            //sv.distribution = .equalSpacing
            sv.alignment = .center
            sv.addArrangedSubview(priceLabelTop)
            sv.addArrangedSubview(priceLabel)
            return sv
        }()
    
        lazy var stackViewTop2: UIStackView = {
            let sv = UIStackView()
            sv.translatesAutoresizingMaskIntoConstraints = false
            sv.axis = .vertical
            sv.spacing = 10
            sv.alignment = .center
            sv.addArrangedSubview(fuelTypeTop)
            sv.addArrangedSubview(fuelType)
            return sv
        }()
    
    lazy var stackViewTop3: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 10
        sv.alignment = .center
        sv.addArrangedSubview(sellingConditionTop)
        sv.addArrangedSubview(sellingCondition)
        return sv
    }()
    
    lazy var detailsStack: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .equalSpacing
        sv.alignment = .center
        sv.addArrangedSubview(stackViewTop1)
        sv.addArrangedSubview(stackViewTop2)
        sv.addArrangedSubview(stackViewTop3)
        return sv
    }()
    
    lazy var buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("✸Buy✸", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        return button
    }()

    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        presenter = DetailsViewPresenter()
        makeResponse = PublishSubject()
        makeResponse = PublishSubject()
    }
    
    deinit {
        presenter = nil
        makeResponse = nil
        makeResponse = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupConstrains()
        if let id = id {
            presenter?.fetchAllVehicles(carId: id)
        }
        configureAllvehicle()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setupConstrains() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        firstSetUp()
        seconViewSetup()
        thirdViewSetup()

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    func firstSetUp() {
        contentView.addSubview(carView)
        carView.addSubview(stackView)
        carView.translatesAutoresizingMaskIntoConstraints = false
        carView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        carView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        carView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50).isActive = true
        carView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: carView.leftAnchor, constant: 20).isActive = true
        stackView.rightAnchor.constraint(equalTo: carView.rightAnchor, constant: -20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: carView.bottomAnchor, constant: -10).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        topCollectionView.translatesAutoresizingMaskIntoConstraints = false
        topCollectionView.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0).isActive = true
        topCollectionView.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0).isActive = true
        topCollectionView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0).isActive = true
        topCollectionView.heightAnchor.constraint(equalToConstant: 170).isActive = true
    }
    
    func seconViewSetup() {
        contentView.addSubview(carView2)
        carView2.addSubview(carimage)
        carView2.translatesAutoresizingMaskIntoConstraints = false
        carView2.topAnchor.constraint(equalTo: carView.topAnchor, constant: -40).isActive = true
        carView2.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 40).isActive = true
        carView2.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -40).isActive = true
        carView2.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        carimage.translatesAutoresizingMaskIntoConstraints = false
        carimage.widthAnchor.constraint(equalToConstant: 250).isActive = true
        carimage.heightAnchor.constraint(equalToConstant: 250).isActive = true
        carimage.centerXAnchor.constraint(equalTo: self.carView2.centerXAnchor).isActive = true
        carimage.centerYAnchor.constraint(equalTo: self.carView2.centerYAnchor).isActive = true
    }
    
    func thirdViewSetup() {
        contentView.addSubview(carView3)
        carView3.addSubview(detailsStack)
        carView3.addSubview(buyButton)
        carView3.addSubview(available)
        
        carView3.translatesAutoresizingMaskIntoConstraints = false
        carView3.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        carView3.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        carView3.topAnchor.constraint(equalTo: carView.bottomAnchor, constant: 20).isActive = true
        carView3.heightAnchor.constraint(equalToConstant: 200).isActive = true
        carView3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        
        detailsStack.translatesAutoresizingMaskIntoConstraints = false
        detailsStack.leftAnchor.constraint(equalTo:  carView3.leftAnchor, constant: 20).isActive = true
        detailsStack.rightAnchor.constraint(equalTo: carView3.rightAnchor, constant: -20).isActive = true
        detailsStack.topAnchor.constraint(equalTo: carView3.topAnchor, constant: -10).isActive = true
        detailsStack.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        buyButton.leftAnchor.constraint(equalTo:  carView3.leftAnchor, constant: 20).isActive = true
        buyButton.rightAnchor.constraint(equalTo: carView3.rightAnchor, constant: -20).isActive = true
        buyButton.bottomAnchor.constraint(equalTo: carView3.bottomAnchor, constant: -10).isActive = true
        buyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        available.translatesAutoresizingMaskIntoConstraints = false
        available.heightAnchor.constraint(equalToConstant: 50).isActive = true
        available.centerXAnchor.constraint(equalTo: self.carView3.centerXAnchor).isActive = true
        available.centerYAnchor.constraint(equalTo: self.carView3.centerYAnchor).isActive = true
    }
    
    func configureAllvehicle() {
        if let response = makeResponse {
            presenter?.getVehicleDetails.observe(on: MainScheduler.instance).bind(to: response).disposed(by: disposeBag)
            response.subscribe(onNext: { [weak self] result in
                guard let this = self else {return}
                this.title = result?.bodyType?.name
                this.carimage.sd_setImage(with: URL(string: result?.imageURL ?? ""))
                this.priceLabel.text = result?.marketplacePrice?.delimiter
                this.fuelType.text = result?.fuelType?.capitalized
                this.sellingCondition.text = result?.sellingCondition?.capitalized
                this.allMakes = result?.inspectorDetails?.inspectedMakes ?? []
                this.allMakesResponse?.onNext(result?.inspectorDetails?.inspectedMakes ?? [])
                if let sold = result?.sold {
                    if sold {
                        
                        this.available.text = "Available 🥳🥳"
                    } else {
                        this.available.text = "Sold ☹️☹️"
                        this.buyButton.isEnabled = false
                    }
                } else {
                    this.available.text = "Not Available ☹️☹️"
                    this.buyButton.isEnabled = false
                }
                if this.allMakes.isEmpty {
                    this.showEmptyState()
                } else {
                    this.hideEmptyState()
                }
                this.topCollectionView.reloadData()
            }).disposed(by: disposeBag)
        }
    }
}

extension DetailsViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allMakes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MakeCollectionViewCell.identifier, for: indexPath) as? MakeCollectionViewCell {
            cell.setupView2(value: allMakes[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func showEmptyState() {
        emptyStateMessage.isHidden = false
        myCollectionView?.isHidden = true
    }
    
    func hideEmptyState() {
        myCollectionView?.isHidden = false
        emptyStateMessage.isHidden = true
    }
}
