//
//  APODDetailViewViewModel.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 11.02.2024.
//

import Foundation

final class APODDetailViewViewModel {
    private let apod: APODModel
    
    init(apod: APODModel) {
        self.apod = apod
    }
    
    public var title: String {
        apod.title.uppercased()
    }
}
