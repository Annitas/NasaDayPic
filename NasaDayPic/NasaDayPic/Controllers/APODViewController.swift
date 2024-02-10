//
//  ViewController.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 09.02.2024.
//

import UIKit
//import Alamofire
import SnapKit

final class APODViewController: UIViewController {
    
    private let apodListView = APODListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "APOD"
        view.addSubview(apodListView)
        setupConstraints()
    }

    private func setupConstraints() {
        apodListView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
        }
    }

}

