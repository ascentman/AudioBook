//
//  CustomSegmentedControl.swift
//  AudioBook
//
//  Created by user on 4/24/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

@IBDesignable
class CustomSegmentControl: UIControl {

    private var buttons: [UIButton] = []
    private var selector: UIView!
    var selectedSegmentIndex = 0

    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable
    var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable
    var commaSeparetedButtonTitles: String = "" {
        didSet {
            updateView()
        }
    }

    @IBInspectable
    var textColor: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }

    @IBInspectable
    var selectorColor: UIColor = UIColor.darkGray {
        didSet {
            updateView()
        }
    }

    @IBInspectable
    var selectorBorderColor: UIColor = UIColor.red {
        didSet {
            updateView()
        }
    }

    @IBInspectable
    var selectorTextColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }

    func updateView() {
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
        let buttonTitles = commaSeparetedButtonTitles.components(separatedBy: ",")
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.font = UIFont(name: "Charter", size: 20)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        }

        buttons.first?.setTitleColor(selectorTextColor, for: .normal)
        let selectorWidth = frame.width / CGFloat(buttonTitles.count)
        selector = UIView(frame: CGRect(x: 0, y: 5, width: selectorWidth, height: frame.height - 10))
        selector.layer.cornerRadius = (frame.height - 10) / 2
        selector.backgroundColor = selectorColor
        selector.layer.borderWidth = 1
        selector.layer.borderColor = selectorBorderColor.cgColor
        addSubview(selector)

        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }

    @objc private func buttonTapped(button: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == button {
                selectedSegmentIndex = buttonIndex
                let selectorStartPosition = frame.width / CGFloat(self.buttons.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selector.frame.origin.x = selectorStartPosition
                }
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
        sendActions(for: .valueChanged)
    }

    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height / 2
        updateView()
    }
}
