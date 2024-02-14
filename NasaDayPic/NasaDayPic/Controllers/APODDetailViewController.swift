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
    private let detailView: APODDetailView
//    private let collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 0
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.backgroundColor = .systemPink
//        return collectionView
//    }()
    
    init(viewModel: APODDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = APODDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
//        title = viewModel.apod.title
        view.addSubview(detailView)
        
        addConstraints()
//        setupCollectionView()
//        fetchAPODInfo(url: viewModel.apod.url)
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
    }
    
    private func addConstraints() {
        detailView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
        }
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
//                        self.collectionView.reloadData()
                        print(String(describing: success))
                    }
                case .failure(let failure):
                    print(String(describing: failure))
                }
            }
        }
    }
}

extension APODDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: APODPhotoCollectionViewCell.cellIdentifier,
                for: indexPath) as? APODPhotoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            cell.backgroundColor = .systemMint
            return cell
        case .title(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: APODTitleExplanationCollectionViewCell.cellIdentifier,
                for: indexPath) as? APODTitleExplanationCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            cell.backgroundColor = .systemBlue
            return cell
            //        case .explanation(let viewModel):
            //            guard let cell = collectionView.dequeueReusableCell(
            //                withReuseIdentifier: APODExplanationCollectionViewCell.cellIdentifier,
            //                for: indexPath) as? APODExplanationCollectionViewCell else {
            //                fatalError()
            //            }
            //            cell.configure(with: viewModel)
            //            cell.backgroundColor = .systemYellow
            //            return cell
            //        }
        }
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return viewModel.sections.count
        }
        //
        //    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return 1
        //    }
        //
        //    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        switch indexPath.section {
        //        case 0:
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCell
        //            // Configure image cell with downloaded image
        //            return cell
        //        case 1:
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "titleCell", for: indexPath) as! TitleCell
        //            // Configure title cell with title text
        //            return cell
        //        case 2:
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "explanationCell", for: indexPath) as! ExplanationCell
        //            // Configure explanation cell with explanation text
        //            return cell
        //        default:
        //            fatalError("Invalid section")
        //        }
        //    }
        //
        //    func collectionView(
        //
        //_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        if indexPath.section == 0 {
        //            // Return dynamic height for image cell based on content offset
        //            return CGSize(width: view.frame.width, height: max(200, -collectionView.contentOffset.y))
        //        } else {
        //            return CGSize(width: view.frame.width, height: 50)
        //        }
        //    }
    }
}
