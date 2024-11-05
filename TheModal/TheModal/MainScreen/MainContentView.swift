//
//  MainContentView.swift
//  TheModal
//
//  Created by Nikita Kuzmin on 04.11.2024.
//

import UIKit

protocol MainContentViewDelegate: AnyObject {
    func handleButtonAction()
}

final class MainContentView: UIView {
    // MARK: - Subviews
    
    private let firstButton = CustomButton()
    private let secondButton = CustomButton()
    private(set) lazy var thirdButton: CustomButton = {
        let button = CustomButton()
        button.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "Kit"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) weak var delegate: MainContentViewDelegate?
    
    // MARK: - Lyfecycle
    
    required init(delegate: MainContentViewDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        backgroundColor = .white
        addSubviews()
        makeConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ viewModel: ViewModel) {
        firstButton.configuration = viewModel.firstButtonConfiguration
        secondButton.configuration = viewModel.secondButtonConfiguration
        thirdButton.configuration = viewModel.thirdButtonConfiguration
    }
    
}

// MARK: - MainContentView + ViewModel

extension MainContentView {
    struct ViewModel: Equatable {
        let firstButtonConfiguration: UIButton.Configuration
        let secondButtonConfiguration: UIButton.Configuration
        let thirdButtonConfiguration: UIButton.Configuration
    }
}

// MARK: - Private

private extension MainContentView {
    
    @objc
    func handleButtonTap() {
        delegate?.handleButtonAction()
    }
    
    func addSubviews() {
        addSubview(stackView)
        addSubview(imageView)
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        stackView.addArrangedSubview(thirdButton)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
