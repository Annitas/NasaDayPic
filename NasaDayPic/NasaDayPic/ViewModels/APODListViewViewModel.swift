//
//  APODListViewViewModel.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 10.02.2024.
//

import Foundation
import UIKit

final class APODListViewViewModel: NSObject {
    func fetchAPOD() {
        let request = Request(pathComponents: ["2"])

        Service.shared.execute(request, expecting: [APODModel].self) { result in
            switch result {
            case .success(let model):
                print(String(describing: model[0]))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension APODListViewViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .yellow
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
}
