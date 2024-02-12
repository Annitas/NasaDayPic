//
//  APODDetailViewController.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 11.02.2024.
//

import UIKit

final class APODDetailViewController: UIViewController {
    private let viewModel: APODDetailViewViewModel
    
    init(viewModel: APODDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
}
