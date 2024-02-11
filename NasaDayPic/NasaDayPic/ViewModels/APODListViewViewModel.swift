//
//  APODListViewViewModel.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 10.02.2024.
//

import Foundation
import UIKit

protocol APODListViewViewModelDelegate: AnyObject {
    func didLoadInitialAPODs()
}

final class APODListViewViewModel: NSObject {
    public weak var delegate: APODListViewViewModelDelegate?
    
    private var apods: [APODModel] = [] {
        didSet {
            for apod in apods {
                let viewModel = APODCollectionViewCellViewModel(title: apod.title, 
                                                                imageURL: URL(string: apod.url))
                print(viewModel.title)
                cellViewModels.append(viewModel)
            }
//            cellViewModels = apods.map { apod in
//                print(apod.title)
//                return APODCollectionViewCellViewModel(title: apod.title, imageURL: URL(string: apod.url))
//            }

        }
    }
    
    private var cellViewModels: [APODCollectionViewCellViewModel] = []

    public func fetchAPOD() {
        Service.shared.execute(.listAPODRequest, expecting: [APODModel].self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                self?.apods = responseModel
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialAPODs()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}


extension APODListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(cellViewModels.count)
        return cellViewModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: APODCollectionViewCell.cellIdentifier, for: indexPath) as? APODCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 30)/2
        return CGSize(width: width, height: width)
    }
}
