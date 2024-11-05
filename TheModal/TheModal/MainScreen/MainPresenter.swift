//
//  MainPresenter.swift
//  TheModal
//
//  Created by Nikita Kuzmin on 05.11.2024.
//

import UIKit

protocol PresentMainScreen: AnyObject {
    func presentModuleData()
}

final class MainPresenter: PresentMainScreen {
    
    // MARK: - Properties
    
    weak var viewController: DisplaysMainScreen?
    
    // MARK: - Initialization

    init(viewController: DisplaysMainScreen?) {
        self.viewController = viewController
    }
    
    // MARK: - Methods

    func presentModuleData() {
        viewController?.displaysModuleData(
            MainContentView.ViewModel(
                firstButtonConfiguration: makeConfiguration("First Button"),
                secondButtonConfiguration: makeConfiguration("Second Medium Button"),
                thirdButtonConfiguration: makeConfiguration("Third")
            )
        )
    }
}

private extension MainPresenter {
    func makeConfiguration(_ title: String, isActive: Bool = false) -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.image = UIImage(systemName: "arrow.right.circle.fill")
        config.imagePlacement = .trailing
        config.imagePadding = 8
        config.contentInsets = .init(top: 10, leading: 14, bottom: 10, trailing: 14)
        return config
    }
}
