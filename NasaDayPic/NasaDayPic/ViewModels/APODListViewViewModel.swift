//
//  APODListViewViewModel.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 10.02.2024.
//

import Foundation

struct APODListViewViewModel {
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
