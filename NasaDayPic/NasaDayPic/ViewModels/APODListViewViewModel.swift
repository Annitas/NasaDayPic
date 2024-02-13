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
    func didSelectAPOD(_ apod: APODModel)
}

final class APODListViewViewModel: NSObject {
    public weak var delegate: APODListViewViewModelDelegate?
    
    private var isLoadingMoreAPODs = false
    
    private var apods: [APODModel] = [] {
        didSet {
            for apod in apods {
                let viewModel = APODCollectionViewCellViewModel(title: apod.title,
                                                                explanation: apod.explanation,
                                                                imageURL: URL(string: apod.url))
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
            
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
    
    public func fetchAdditionalAPODs() {
        guard !isLoadingMoreAPODs else {
            return
        }
        isLoadingMoreAPODs = true
        Service.shared.execute(.listAPODRequest,
                               expecting: [APODModel].self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                self?.apods.append(contentsOf: responseModel)
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialAPODs()
                    self?.isLoadingMoreAPODs = false
                }
            case .failure(let error):
                self?.isLoadingMoreAPODs = false
                print(String(describing: error))
            }
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool { // bottom spinner
        return true
    }
}


extension APODListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: APODCollectionViewCell.cellIdentifier, for: indexPath) as? APODCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter else {
            fatalError("Unsupported Footer")
        }
        guard let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: FooterLoadingCollectionReusableView.identifier,
            for: indexPath
        ) as? FooterLoadingCollectionReusableView else { fatalError("OooOOops") }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 30)/2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let apod = apods[indexPath.row]
        delegate?.didSelectAPOD(apod)
    }
}

extension APODListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator, !isLoadingMoreAPODs, !cellViewModels.isEmpty else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self?.fetchAdditionalAPODs()
            }
            t.invalidate()
        }
    }
}
