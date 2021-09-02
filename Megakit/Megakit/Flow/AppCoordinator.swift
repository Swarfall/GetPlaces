//
//  AppCoordinator.swift
//  Megakit
//
//  Created by Viacheslav Savitskyi on 31.08.2021.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let navigation: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        self.navigation = UINavigationController()
        self.window.rootViewController = navigation
    }
    
    func start() {
        let router = ListRouter()
        let viewController = router.build()
        navigation.setViewControllers([viewController], animated: true)
    }
}
