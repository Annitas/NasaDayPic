//
//  APODListView.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 10.02.2024.
//

import UIKit
import SnapKit

final class APODListView: UIView {
    
    private let viewModel = APODListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell")
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .brown
        
        addSubview(spinner)
        addSubview(collectionView)
        
        addConstraints()
//        viewModel.fetchAPOD()
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.spinner.stopAnimating()
            self.collectionView.isHidden = false
            UIView.animate(withDuration: 0.4) {
                self.collectionView.alpha = 1
            }
            })
    }
}
