//
//  ExpandButton.swift
//  ButtonAnimationSample
//
//  Created by 木元健太郎 on 2021/11/09.
//


import UIKit

final class ExpandButton: UIView {

    let baseColor = UIColor.black

    fileprivate var actionButtons: [MenuButton]?
    fileprivate lazy var menuButton: MenuButton = {
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .black, scale: .large)
        let image = UIImage(systemName: "plus", withConfiguration: config)!
        let frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        let button = MenuButton(frame: frame, image: image, baseColor: baseColor, action: nil)
        button.addTarget(self, action: #selector(toggleButton(_:)), for: .touchUpInside)
        return button
    }()

    fileprivate var isExpanded: Bool = false {
        didSet {
            updateViews()
        }
    }

    init(actionButtons: [ActionButtonModel]) {
        super.init(frame: .zero)
        addSubview(menuButton)

        self.actionButtons = actionButtons.map {
            let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .black, scale: .large)
            let image = UIImage(systemName: $0.sfsymbolsName, withConfiguration: config)!

            let frame = CGRect(x: 0, y: 0, width: 60, height: 60)
            let button = MenuButton(frame: frame, image: image, baseColor: baseColor, action: $0.action)
            button.addTarget(self, action: #selector(tapAcctionButton(_:)), for: .touchUpInside)

            button.alpha = 0.0
            button.isEnabled = false
            insertSubview(button, at: 0)

            return button
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ExpandButton {
    @objc func toggleButton(_ sender: MenuButton) {
        isExpanded = !isExpanded
    }

    @objc func tapAcctionButton(_ sender: MenuButton) {
        sender.tapActionBlock?()
    }

    func updateViews() {
        menuButton.isSelected = !menuButton.isSelected

        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            guard let buttons = self.actionButtons else { return }
            switch self.isExpanded {
            case true:
                for (index, button) in buttons.enumerated() {
                    button.alpha = 1.0
                    button.isEnabled = true
                    button.transform = CGAffineTransform(translationX: CGFloat(80*(index+1)), y: 0)
                }

            case false:
                self.actionButtons?.forEach {
                    $0.alpha = 0.0
                    $0.isEnabled = false
                    $0.transform = .identity
                }
            }
        }
    }
}
