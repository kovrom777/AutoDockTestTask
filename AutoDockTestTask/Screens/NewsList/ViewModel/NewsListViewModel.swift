//
//  NewsListViewModel.swift
//  AutoDockTestTask
//
//  Created by Роман Ковайкин on 19.06.2023.
//

import Foundation
import UIKit

enum Section: Int, CaseIterable {
    case grid
}

class NewsListViewModel {

    //MARK: - Public Properties
    @Published var newsArray: [SingleNews] = []
    @Published var error: String?
    var dataSource: UICollectionViewDiffableDataSource<Section, SingleNews>! = nil
    var layout: UICollectionViewCompositionalLayout!
    
    //MARK: - Private Properties
    private var isFetchingData: Bool = false
    private var currentPage: Int = 1
    
    
    init(news: News? = nil){
        loadData()
    }
    
    private func loadData(pageSize: Int = 15) {
        Task(priority: .high) {
            do {
                isFetchingData = true
                let _news: News = try await NetworkManager.request(endPoint: GetNewsEndPoint.requestNews(page: currentPage, pageSize: pageSize))
                newsArray.append(contentsOf: _news.news)
                currentPage += 1
                isFetchingData = false
            } catch {
                self.error = error.localizedDescription
                isFetchingData = false
            }
        }
    }
}

//MARK: - Collection view config methods
extension NewsListViewModel {
    func getCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsListCollectionViewCell.cellId, for: indexPath) as? NewsListCollectionViewCell else {return UICollectionViewCell()}
        let newsAtIndexPath = newsArray[indexPath.row]
        cell.setUpData(news: newsAtIndexPath)
        return cell
    }
    
    func willDisplayCell(at indexPath: IndexPath) {
        guard !isFetchingData else {return}
        if indexPath.row == newsArray.count - 2 {
            loadData()
        }
    }
    
    func didSelectCell(at indexPath: IndexPath, from viewController: UIViewController) {
        let data = newsArray[indexPath.row]
        let controller = DetailNewsinfoViewController(news: data)
        viewController.navigationController?.pushViewController(controller, animated: true)
    }
    
    func configureDataSource(for collectionView: UICollectionView) {
        dataSource = UICollectionViewDiffableDataSource<Section, SingleNews>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return self.getCell(for: collectionView, at: indexPath)
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, SingleNews>()
        snapshot.appendSections([.grid])
        snapshot.appendItems(self.newsArray, toSection: .grid)
        dataSource.apply(snapshot, animatingDifferences: false)
        
        dataSource.supplementaryViewProvider = { [unowned self] (collectionView, kind, indexPath) in
            guard let footerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: FooterLoadingView.cellId, for: indexPath) as? FooterLoadingView else { fatalError() }
            footerView.toggleLoading(isEnabled: isFetchingData)
            return footerView
        }
    }
    
    func reloadSnapshot() {
        var snap = NSDiffableDataSourceSnapshot<Section, SingleNews>()
        snap.appendSections([.grid])
        snap.appendItems(self.newsArray)
        dataSource.apply(snap, animatingDifferences: false)
    }
    
}
