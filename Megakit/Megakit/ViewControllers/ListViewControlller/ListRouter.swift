//
//  ListRouter.swift
//  Megakit
//
//  Created by Viacheslav Savitskyi on 31.08.2021.
//

import Foundation

final class ListRouter {
    
    func build() -> ListViewController {
        let viewController = ListViewController.storyboardViewController() as ListViewController
        return viewController
    }
}
