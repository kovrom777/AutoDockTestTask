//
//  DetailNewsinfoView.swift
//  AutoDockTestTask
//
//  Created by Роман Ковайкин on 20.06.2023.
//

import UIKit

class DetailNewsinfoView: UIView {
    
    //MARK: - Properties
    let imageView = UIImageView()
    let newsTextView = UITextView()
    let viewFromWebButton = UIButton()
    let news: SingleNews
    
    //MARK: - Init methods
    init(news: SingleNews) {
        self.news = news
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        imageView.image = UIImage(named: "noImage")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        newsTextView.textColor = .black
        newsTextView.font = .systemFont(ofSize: 18)
        newsTextView.textAlignment = .justified
        newsTextView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(newsTextView)
        
        viewFromWebButton.setTitle("Посмотреть оригинал новости", for: .normal)
        viewFromWebButton.setTitleColor(.black, for: .normal)
        viewFromWebButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        viewFromWebButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(viewFromWebButton)
        
        configureView(news: news)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    private func configureView(news: SingleNews) {
        newsTextView.text = news.description
        guard let url = news.titleImageUrl else {return}
        Task(priority: .high) { [weak self] in
            guard let self else {return}
            await self.loadImage(from: url)
        }
    }
    
    private func loadImage(from url: String) async {
        do {
            try await imageView.loadImage(from: url)
        } catch {
            print(error)
        }
    }
    
    private func makeConstraints() {
        imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
        imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12).isActive = true
        imageView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -50).isActive = true
        
        viewFromWebButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        viewFromWebButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        newsTextView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 28).isActive = true
        newsTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        newsTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        newsTextView.bottomAnchor.constraint(equalTo: viewFromWebButton.topAnchor, constant: -20).isActive = true
        
    }

}
