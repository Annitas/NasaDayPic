//
//  APODTitleCollectionViewCell.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 12.02.2024.
//

import UIKit
import SnapKit

final class APODTitleExplanationCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "APODTitleCollectionViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let explanationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(explanationLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        explanationLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        explanationLabel.text = nil
    }
    
    public func configure(with viewModel: APODTitleCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        explanationLabel.text = viewModel.explanation
    }
}
