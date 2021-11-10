//
//  ViewController.swift
//  ButtonAnimationSample
//
//  Created by 木元健太郎 on 2021/11/08.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    fileprivate lazy var expandButton: ExpandButton = {
        let button = ExpandButton(actionButtons: [
            ActionButtonModel(sfsymbolsName: "person.fill.badge.plus", action: {
                print("ボタン1")
            }),
            ActionButtonModel(sfsymbolsName: "message.fill", action: {
                print("ボタン2")
            }),
            ActionButtonModel(sfsymbolsName: "phone.fill", action: {
                print("ボタン3")
            }),
        ])
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(expandButton)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        expandButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-32)
        }
    }
}
