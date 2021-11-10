//
//  MenuButton.swift
//  ButtonAnimationSample
//
//  Created by 木元健太郎 on 2021/11/09.
//

import UIKit

typealias ActionBlock = () -> ()

class MenuButton: UIButton {

    let baseColor: UIColor
    var tapActionBlock: ActionBlock?

    init(frame: CGRect, image: UIImage, baseColor: UIColor, action: ActionBlock?) {
        self.baseColor = baseColor
        self.tapActionBlock = action
        super.init(frame: frame)

        layer.cornerRadius = frame.width / 2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 3.0
        layer.shadowOffset = .zero

        setImage(image, for: .normal)
        setImage(image, for: .highlighted)

        self.isSelected = false
    }

    override var isSelected: Bool {
        didSet {
            updateViews()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuButton {
    private func updateViews() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            switch self.isSelected {
            case true:
                self.tintColor = self.baseColor
                self.backgroundColor = .white
                let angle: CGFloat = 45 * CGFloat.pi / 180
                self.transform = CGAffineTransform(rotationAngle: angle)
            case false:
                self.tintColor = .white
                self.backgroundColor = self.baseColor
                self.transform = .identity
            }
        }
    }
}

extension MenuButton {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchStartAnimation()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touchEndAnimation()
    }

    private func touchStartAnimation() {
        UIView.animate(withDuration: 0.05, animations: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.transform = strongSelf.transform.scaledBy(x: 0.95, y: 0.95)
            strongSelf.alpha = 0.9
        })
    }

    private func touchEndAnimation() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.transform = strongSelf.transform.scaledBy(x: 1.052631579, y: 1.052631579)
            strongSelf.alpha = 1.0
        })
    }
}
