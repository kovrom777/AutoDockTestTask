//
//  ViewController.swift
//  AutoDockTestTask
//
//  Created by Роман Ковайкин on 15.06.2023.
//

import UIKit
import Combine

class NewsListViewController: UIViewController {
    //MARK: - Properties
    let contentView = NewsListView()
    let viewModel = NewsListViewModel()
    var cancellable: Set<AnyCancellable> = []

    //MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        listenForNewsUpdate()
    }
    
    override func loadView() {
        view = contentView
    }
    
    deinit {
        cancellable.forEach({
            $0.cancel()
        })
        cancellable.removeAll()
    }

    //MARK: - Private methods
    private func configCollectionView() {
        contentView.collectionView.delegate = self
        contentView.collectionView.register(NewsListCollectionViewCell.self, forCellWithReuseIdentifier: NewsListCollectionViewCell.cellId)
        contentView.collectionView.register(
            FooterLoadingView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: FooterLoadingView.cellId)
        contentView.collectionView.collectionViewLayout = contentView.getLayoutForDevice()
        
        viewModel.configureDataSource(for: contentView.collectionView)
        print(#function)
    }
    
    
    private func listenForNewsUpdate() {
        viewModel.$newsArray.sink { [weak self] _ in
            guard let self else {return}
            DispatchQueue.main.async {
                self.viewModel.reloadSnapshot()
            }
        }.store(in: &cancellable)
        
        viewModel.$error.sink { [weak self] error in
            guard let self else {return}
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    self.showError(error: error)
                }
                
            }
        }.store(in: &cancellable)
        
        NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification).sink { [weak self] _ in
            guard let self else {return}
            self.contentView.collectionView.collectionViewLayout.invalidateLayout()
        }.store(in: &cancellable)

    }
}

//MARK: Extensions
extension NewsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.willDisplayCell(at: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectCell(at: indexPath, from: self)
    }
}

//MARK: - Needed only for VC Prefiew
import SwiftUI
struct NewsPreview: PreviewProvider {
    static var previews: some View{
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            UINavigationController(rootViewController: NewsListViewController())
        }
        
        typealias UIViewControllerType = UIViewController
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}


