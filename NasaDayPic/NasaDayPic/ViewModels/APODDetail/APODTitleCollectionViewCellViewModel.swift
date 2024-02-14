//
//  APODTitleCollectionViewCellViewModel.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 12.02.2024.
//

import Foundation

final class APODTitleCollectionViewCellViewModel {
    public let title: String
    public let explanation: String
    
    init(title: String, explanation: String) {
        self.title = title
        self.explanation = explanation
    }
}
