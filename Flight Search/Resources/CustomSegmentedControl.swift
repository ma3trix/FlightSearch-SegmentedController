//
//  CustomSegmentedControl.swift
//  Flight Search
//
//  Created by Malik Adebiyi on 2020-06-25.
//  Copyright © 2020 dotSandbox. All rights reserved.
//

import UIKit

@IBDesignable
class CustomSegmentedControl: UIView {
    var buttons = [UIButton]()
    var selector : UIView!
    
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
    var separatedTitles: String = "" {
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var textColor: UIColor = .lightGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorColor: UIColor = .darkGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorTextColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        // clear the array when the function is called
        buttons.removeAll()
        // clear the subviews
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        let buttonTitles = separatedTitles.components(separatedBy: ",")
        
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        // change color of default selected button
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        
        // add selctor to UIView
        let selectorWidth = frame.width / CGFloat(buttonTitles.count)
        selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth, height: frame.height))
        selector.layer.cornerRadius = frame.height / 2
        selector.backgroundColor = selectorColor
        addSubview(selector)
        
        
        
        // add stackView
        let sv = UIStackView(arrangedSubviews: buttons)
        // configure stackView
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        // add  StackView yo uiView
        addSubview(sv)
        // remove auto reseizing constraint
        sv.translatesAutoresizingMaskIntoConstraints = false
        // set new consttraint
        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sv.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        sv.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height / 2
    }
    
    @objc func buttonTapped(button: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            
            if btn == button {
                let selectorStartPosition = frame.width/CGFloat(buttons.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3, animations: {
                    self.selector.frame.origin.x = selectorStartPosition
                })
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }
    
    
}
