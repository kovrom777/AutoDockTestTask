//
//  ErrorViewController.swift
//  AutoDockTestTask
//
//  Created by Роман Ковайкин on 19.06.2023.
//

import UIKit


class ErrorViewController: UIViewController {
    //MARK: - Properties
    let contentView: ErrorView
    
    
    //MARK: - Inits
    init(error: String) {
        contentView = ErrorView(error: error)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - VC LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configGestures()
    }
    
    private func configGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideScreen))
        contentView.addGestureRecognizer(tap)
    }
    
    @objc private func hideScreen(){
        self.dismiss(animated: true)
    }
    
    override func loadView() {
        view = contentView
    }
}
