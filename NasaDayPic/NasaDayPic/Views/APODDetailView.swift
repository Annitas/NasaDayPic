//
//  APODDetailView.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 11.02.2024.
//

import UIKit
import SnapKit

final class APODDetailView: UIView {
    
    
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
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
//    private let viewModel = APODDetailViewViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
//        backgroundColor = .systemPink
        addSubview(imageView)
        print("VIEW: \(titleLabel.text)")
        addSubview(titleLabel)
        addSubview(explanationLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    public func configure(with viewModel: APODModel) {
        titleLabel.text = viewModel.title
        print("CONFIGURE: \(titleLabel.text)")
        explanationLabel.text = viewModel.explanation
//        print(viewModel.title)
//        viewModel.fetchImage { [weak self] result in
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    let image = UIImage(data: data)
//                    self?.imageView.image = image
//                }
//            case .failure(let error):
//                print(String(describing: error))
//                break
//            }
//        }
    }
}
