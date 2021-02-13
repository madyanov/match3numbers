//
//  AlertProvider.swift
//  Match3Numbers
//
//  Created by Roman Madyanov on 13.02.2021.
//

import UIKit

struct AlertAction {
    let title: String
    let handler: (() -> Void)?
}

protocol AlertProvider: AnyObject {
    func showAlert(title: String?, message: String?, actions: [AlertAction])
}

extension AlertProvider where Self: UIViewController {
    func showAlert(title: String?, message: String?, actions: [AlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        for action in actions {
            alert.addAction(UIAlertAction(title: action.title,
                                          style: .default,
                                          handler: { _ in action.handler?() }))
        }

        self.present(alert, animated: true, completion: nil)
    }
}
