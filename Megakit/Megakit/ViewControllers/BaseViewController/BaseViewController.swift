//
//  BaseViewController.swift
//  Megakit
//
//  Created by Viacheslav Savitskyi on 31.08.2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Private property
    private static let loaderTag = 9_999
    
    // MARK: - Public methods
    func showLoader() {
        let previousIndicator = view.viewWithTag(BaseViewController.loaderTag)
        previousIndicator?.removeFromSuperview()
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.tag = BaseViewController.loaderTag
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func hideLoader() {
        let indicator = view.viewWithTag(BaseViewController.loaderTag)
        indicator?.removeFromSuperview()
        view.isUserInteractionEnabled = true
    }
    
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
}

