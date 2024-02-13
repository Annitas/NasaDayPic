//
//  APODDetailViewViewModel.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 11.02.2024.
//

import Foundation
import UIKit

final class APODDetailViewViewModel {
//    public var title: String = ""
//    public var explanation: String = ""
    public var image = UIImageView()
    
    public let apod: APODModel
    private let apodView = APODDetailView()
    
    
    init(apod: APODModel) {
//        apodView.configure(with: apod)
        self.apod = apod
//        print(apod.title)
//        print(apod.explanation)
    }
    
    private var requestURL: URL? {
        return URL(string: apod.url)
    }
    
    public func fetchAPODInfo() {
        guard let url = requestURL else {
            return
        }
        ImageLoader.shared.downLoadImage(url) { result in
            switch result {
            case .success(let success):
                self.image.image = UIImage(data: success)
                print(String(describing: success))
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
}
