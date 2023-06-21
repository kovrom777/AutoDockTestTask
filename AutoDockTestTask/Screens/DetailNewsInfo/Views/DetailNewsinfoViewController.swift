//
//  DetailNewsinfoViewController.swift
//  AutoDockTestTask
//
//  Created by Роман Ковайкин on 20.06.2023.
//

import UIKit

class DetailNewsinfoViewController: UIViewController {
    //MARK: - Properties
    let contentView:DetailNewsinfoView
    private let news: SingleNews
   
    //MARK: - VC lifecycle
    init(news: SingleNews) {
        self.news = news
        contentView = DetailNewsinfoView(news: news)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContentView()
    }
    
    override func loadView() {
        view = contentView
    }
    
    //MARK: - Private methods
    private func configureContentView() {
        contentView.viewFromWebButton.addTarget(self, action: #selector(showNewsFromBrowser), for: .touchUpInside)
    }
    
    //MARK: - Actions
    @objc private func showNewsFromBrowser() {
        guard let url = URL(string: news.fullUrl) else {return}
        UIApplication.shared.open(url)
    }
}
