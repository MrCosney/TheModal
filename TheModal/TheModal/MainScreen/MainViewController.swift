//
//  ViewController.swift
//  TheModal
//
//  Created by Nikita Kuzmin on 04.11.2024.
//

import UIKit

protocol DisplaysMainScreen: AnyObject {
    func displaysModuleData(_ viewModel: MainContentView.ViewModel)
}

final class MainViewController: UIViewController {
    // MARK: - Properties
    
    private(set) lazy var contentView = MainContentView(delegate: self)
    
    private(set) var presenter: PresentMainScreen?
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainPresenter(viewController: self)
        presenter?.presentModuleData()
    }
}

// MARK: - DisplaysMainView

extension MainViewController: DisplaysMainScreen {
    func displaysModuleData(_ viewModel: MainContentView.ViewModel) {
        contentView.configure(viewModel)
    }
}

// MARK: - MainContentViewDelegate

extension MainViewController: MainContentViewDelegate {
    func handleButtonAction() {
        let modalVC = ModalScreenViewController()
        present(modalVC, animated: true)
    }
}
