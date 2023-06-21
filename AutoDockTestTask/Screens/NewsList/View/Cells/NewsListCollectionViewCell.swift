//
//  NewsListCollectionViewCell.swift
//  AutoDockTestTask
//
//  Created by Роман Ковайкин on 20.06.2023.
//

import UIKit

class NewsListCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Prperties
    static let cellId = "NewsCollectionViewCellId"
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                UIView.animate(withDuration: 0.2) {
                    self.contentView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                    self.isSelected = false
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.contentView.transform = .identity
                }
            }
        }
    }
    //MARK: Init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 12
        
        imageView.image = UIImage(named: "noImage")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Public methods
    public func setUpData(news: SingleNews) {
        Task(priority: .medium) { [weak self] in
            guard let self else {return}
            guard let imageURL = news.titleImageUrl else {
                self.imageView.image = UIImage(named: "noImage")
                return
            }
            await self.loadImage(url: imageURL)
        }
        
        titleLabel.text = news.title
    }
    
    //MARK: - Private methods
    private func loadImage(url: String) async {
        do {
            try await imageView.loadImage(from: url)
        } catch {
            print("Failed to load image with error: \(error)")
        }
    }
    
    private func makeConstraints() {
        
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 50).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        
    }
    
}
