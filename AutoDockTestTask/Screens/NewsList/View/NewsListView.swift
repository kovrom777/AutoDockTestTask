//
//  NewsListView.swift
//  AutoDockTestTask
//
//  Created by Роман Ковайкин on 19.06.2023.
//

import UIKit

class NewsListView: UIView {
    var collectionView:UICollectionView
    
    override init(frame: CGRect) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        super.init(frame: frame)
        
        backgroundColor = .white
        
        collectionView.allowsMultipleSelection = false
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(collectionView)
        
        makeConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getLayoutForDevice() -> UICollectionViewLayout {
        return UIDevice.current.userInterfaceIdiom == .pad ? createLayoutForIpad() : createLayoutForIphone()
    }
    
    private func createLayoutForIphone() -> UICollectionViewLayout{
        let layout: UICollectionViewCompositionalLayout = .init(sectionProvider: { sectionIndex, env in
            guard let section = Section(rawValue: sectionIndex) else { return nil }
            switch section {
            case .grid:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
                item.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3)), subitems: [item])
                group.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
                let section = NSCollectionLayoutSection(group: group)
                let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
                let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
                section.boundarySupplementaryItems = [footer]
                return section
            }
        })
        return layout
    }
    
    private func createLayoutForIpad() -> UICollectionViewLayout {
        let layout: UICollectionViewCompositionalLayout = .init(sectionProvider: { sectionIndex, env in
            guard let section = Section(rawValue: sectionIndex) else { return nil }
            switch section {
            case .grid:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1)))
                item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4)), subitems: [item])
                
                group.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
                
                let section = NSCollectionLayoutSection(group: group)
                
                let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
                let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
                section.boundarySupplementaryItems = [footer]
                return section
            }
        })
        return layout
    }
    
   
    
    private func makeConstraints() {
        collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
