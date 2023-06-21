//
//  UIViewController+Extension.swift
//  AutoDockTestTask
//
//  Created by Роман Ковайкин on 19.06.2023.
//

import UIKit

extension UIViewController {
    
    func showError(error: String) {
        let controller = ErrorViewController(error: error)
        controller.modalPresentationStyle = .overFullScreen
        DispatchQueue.main.async {
            self.present(controller, animated: true)
        }
    }
}
