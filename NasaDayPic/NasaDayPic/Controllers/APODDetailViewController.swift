//
//  APODDetailViewController.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 11.02.2024.
//

import UIKit
import SnapKit

final class APODDetailViewController: UIViewController {
    private let viewModel: APODDetailViewViewModel
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let explanationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        return imageView
    }()
//    private let detailView = APODDetailView()
    
    init(viewModel: APODDetailViewViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.apod.title
        explanationLabel.text = viewModel.apod.explanation
        super.init(nibName: nil, bundle: nil)
        fetchAPODInfo(url: viewModel.apod.url)
//        imageView = viewModel.
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(explanationLabel)
//        view.addSubview(detailView)
        addConstraints()
//        viewModel.fetchAPODInfo()
    }
    
    func fetchAPODInfo(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        
        DispatchQueue.global().async {
            ImageLoader.shared.downLoadImage(url) { result in
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: success)
                        print(String(describing: success))
                    }
                case .failure(let failure):
                    print(String(describing: failure))
                }
            }
        }
    }
    
    private func addConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(5)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(5)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(5)
        }
        explanationLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(5)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(5)
        }
    }
}
