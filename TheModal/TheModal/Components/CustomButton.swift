//
//  CustomButton.swift
//  TheModal
//
//  Created by Nikita Kuzmin on 04.11.2024.
//

import UIKit

final class CustomButton: UIButton {
    // MARK: - Properties
    
    private var animator: UIViewPropertyAnimator?
    
    override var isHighlighted: Bool {
        didSet { if isHighlighted { isHighlighted = false } }
    }
            
    // MARK: - Initialization
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        layer.cornerRadius = 5.0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Methods
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        switch tintAdjustmentMode {
        case .dimmed:
            setAppeareance(isDimmed: true)
        default:
            setAppeareance(isDimmed: false)
        }
    }
}

// MARK: - Private

private extension CustomButton {
    enum Constants {
        static let animationDuration: CGFloat = 0.3
        static let scaleTransform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    }
    
    @objc private func touchDown() {
        animate(scale: Constants.scaleTransform)
    }

    @objc private func touchUp() {
        animate(scale: .identity)
    }
    
    func animate(scale: CGAffineTransform) {
        animator?.stopAnimation(true)
        animator = UIViewPropertyAnimator(duration: Constants.animationDuration, curve: .easeOut) {
            self.transform = scale
        }
        animator?.startAnimation()
    }
    
    func setAppeareance(isDimmed: Bool) {
        let tintColor: UIColor = isDimmed ? .systemGray3 : .white
        backgroundColor = isDimmed ? .systemGray2 : .clear
        titleLabel?.textColor = tintColor
        imageView?.tintColor = tintColor
    }
}
