//
//  APODListView.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 10.02.2024.
//

import UIKit
import SnapKit

protocol APODListViewDelegate: AnyObject {
    func apodListView( _ apodListView: APODListView, didSelectAPOD: APODModel)
}

final class APODListView: UIView {
    
    private let viewModel = APODListViewViewModel()
    
    public weak var delegate: APODListViewDelegate?
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(APODCollectionViewCell.self,
                                forCellWithReuseIdentifier: APODCollectionViewCell.cellIdentifier)
        collectionView.register(FooterLoadingCollectionReusableView.self, 
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: FooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        viewModel.fetchAPOD()
        viewModel.delegate = self
        addSubview(spinner)
        addSubview(collectionView)
        addConstraints()
        spinner.startAnimating()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        spinner.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
                
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
}

extension APODListView: APODListViewViewModelDelegate {
    func didSelectAPOD(_ apod: APODModel) {
        delegate?.apodListView(self, didSelectAPOD: apod)
    }
    
    func didLoadInitialAPODs() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }

    }
}
