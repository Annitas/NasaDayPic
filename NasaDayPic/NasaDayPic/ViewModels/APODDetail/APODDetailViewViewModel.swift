//
//  APODDetailViewViewModel.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 11.02.2024.
//

import Foundation
import UIKit

final class APODDetailViewViewModel {
    private let apod: APODModel
    
    enum SectionType {
        case photo(viewModel: APODPhotoCollectionViewCellViewModel)
        case title(viewModel: APODTitleCollectionViewCellViewModel)
//        case explanation(viewModel: APODExplanationCollectionViewCellViewModel)
    }
    
    public var sections: [SectionType] = []
    
    init(apod: APODModel) {
        self.apod = apod
        setupSections()
    }
    
    private func setupSections() {
        sections = [
            .photo(viewModel: .init(imageUrl: URL(string: apod.url))),
            .title(viewModel: .init(title: apod.title, explanation: apod.explanation)) 
//            .explanation(viewModel: .init())
        ]
    }
    
    private var requestURL: URL? {
        return URL(string: apod.url)
    }
    
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.5)
        ),
                                                     subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createTitleSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(100)),
                                                     subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createExplanationSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.5)),
                                                     subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
