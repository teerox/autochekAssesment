//
//  HomeViewController.swift
//  Mobile Assessment
//
//  Created by Anthony Odu on 12/4/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    private var presenter: HomeViewPresenter?
    let disposeBag = DisposeBag()
    
    private var response: PublishSubject<[AllVehicles]>?
    private var allCars: [AllVehicles] = []
    private var makeResponse: PublishSubject<[MakeList]>?
    private var allMakes: [MakeList] = []
    private var car: AllVehicles?
    
    var myCollectionView:UICollectionView?
    
    var carsCollectionView:UICollectionView?
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.addArrangedSubview(topCollectionView)
        sv.addArrangedSubview(bottomCollectionView)
        sv.backgroundColor = .black
    
        topCollectionView.translatesAutoresizingMaskIntoConstraints = false
        bottomCollectionView.translatesAutoresizingMaskIntoConstraints = false
        topCollectionView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        bottomCollectionView.topAnchor.constraint(equalTo: bottomCollectionView.bottomAnchor, constant: 100).isActive = true
        return sv
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
        myCollectionView?.backgroundColor = .lightGray
        return myCollectionView ?? UICollectionView()
    }()
    
    lazy var bottomCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        carsCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        layout.sectionInset = UIEdgeInsets(top: 50, left: 10, bottom: 40, right: 10)
        layout.itemSize = CGSize(width: view.frame.size.width - 4, height: view.frame.size.height / 2)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 40
        layout.minimumInteritemSpacing = 40
        carsCollectionView?.backgroundColor = .lightGray
        carsCollectionView?.showsHorizontalScrollIndicator = false
        carsCollectionView?.showsVerticalScrollIndicator = false
        carsCollectionView?.register(CarCollectionViewCell.self, forCellWithReuseIdentifier: CarCollectionViewCell.identifier)
        return carsCollectionView ?? UICollectionView()
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
        presenter = HomeViewPresenter()
        response = PublishSubject()
        makeResponse = PublishSubject()
    }
    
    deinit {
        presenter = nil
        response = nil
        makeResponse = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cars"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .lightGray
        setupConstrains()
        presenter?.fetchAllVehicles()
        presenter?.fetchAllBrands()
        configureAllvehicle()
        configureAllBrands()
        setupMakeBinding()
        setupCarBinding()
    }
    
    func setupConstrains() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func configureAllBrands() {
        if let response = makeResponse {
            presenter?.getmakes.observe(on: MainScheduler.instance).bind(to: response).disposed(by: disposeBag)
        }
    }
    
    func configureAllvehicle() {
        if let response = response {
            presenter?.getVehicle.observe(on: MainScheduler.instance).bind(to: response).disposed(by: disposeBag)
        }
    }
    
    private func setupMakeBinding(){
        if let response = makeResponse, let myCollectionView = myCollectionView {
            response.bind(to: myCollectionView.rx.items(cellIdentifier: MakeCollectionViewCell.identifier,cellType: MakeCollectionViewCell.self)){
                (row,makes,cell) in
                cell.setupView(value: makes)
            }.disposed(by: disposeBag)
            
            myCollectionView.rx.willDisplayCell
                .subscribe(onNext: ({ (cell,indexPath) in
                    cell.alpha = 0
                    let transform = CATransform3DTranslate(CATransform3DIdentity, 0, -250, 0)
                    cell.layer.transform = transform
                    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                        cell.alpha = 1
                        cell.layer.transform = CATransform3DIdentity
                    }, completion: nil)
                })).disposed(by: disposeBag)
        }
    }
    
    private func setupCarBinding(){
        if let response = response, let myCollectionView = carsCollectionView {
            response.bind(to: myCollectionView.rx.items(cellIdentifier: CarCollectionViewCell.identifier,cellType: CarCollectionViewCell.self)) { [weak self]
                (row,makes,cell) in
                cell.setupView(value: makes)
                cell.xButton.addTarget(self, action: #selector(self?.handleX(sender:)), for: .touchUpInside)
                cell.tag = row
                self?.car = makes
            }.disposed(by: disposeBag)
        }
    }
    
    @objc func handleX(sender: UIButton) {
        let vc = DetailsViewController()
        vc.id = car?.id
        navigationController?.pushViewController(vc, animated: true)
    }
}

