//
//  ModalScreenContentView.swift
//  TheModal
//
//  Created by Nikita Kuzmin on 05.11.2024.
//

import UIKit

final class ModalScreenContentView: UIView {
    
    private enum Constants {
        static let mesaage = "Много людей погорело на этом задании"
        static let imageName = "Hello"
    }
    
    // MARK: - Subviews

    private(set) lazy var imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: Constants.imageName))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.mesaage
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.mesaage
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        backgroundColor = #colorLiteral(red: 0.5031871796, green: 0.5181349516, blue: 0.522176981, alpha: 1)
        addSubviews()
        makeConstraints()
        startAnimation()
        rotateLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ModalScreenContentView {
    func rotateLabels() {
        let rotationAngle = CGFloat(25 * Float.pi / 180)
        topLabel.transform = CGAffineTransform(rotationAngle: rotationAngle)
        bottomLabel.transform = CGAffineTransform(rotationAngle: -rotationAngle)
    }
    
    func addSubviews() {
        addSubview(imageView)
        addSubview(topLabel)
        addSubview(bottomLabel)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            
            topLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -10),
            topLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            bottomLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            bottomLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    func startAnimation() {
        imageView.transform = CGAffineTransform.identity
        UIView.animate(
            withDuration: 2,
            delay: 0,
            options: [.repeat, .autoreverse]) {
                self.imageView.transform = CGAffineTransform(scaleX: -1, y: 1)
            } completion: { _ in self.startAnimation() }
    }
}
