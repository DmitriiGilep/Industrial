//
//  CustomButton.swift
//  Industrial
//
//  Created by DmitriiG on 18.08.2022.
//

import UIKit

class CustomButton: UIButton {
    
    typealias Action = () -> Void
    var buttonAction: Action
    
    // = nil - значение по умолчанию, не применимо для кортежей
    init(
        title: (name: String, state: UIControl.State?),
        titleColor: (color: UIColor?, state: UIControl.State?),
        titleLabelColor: UIColor? = nil,
        titleFont: UIFont? = nil,
        cornerRadius: CGFloat? = nil,
        backgroundColor: UIColor? = nil,
        backgroundImage: (image: UIImage?, state: UIControl.State?),
        clipsToBounds: Bool? = nil,
        action: @escaping Action)
    {
        buttonAction = action
        super.init(frame: CGRect())
        setTitle("\(title.name)", for: title.state ?? .normal)
        setTitleColor(titleColor.color, for: titleColor.state ?? .normal)
        titleLabel?.textColor = titleLabelColor
        titleLabel?.font = titleFont
        layer.cornerRadius = cornerRadius ?? 0.0
        self.backgroundColor = backgroundColor ?? .white
        setBackgroundImage(backgroundImage.image, for: backgroundImage.state ?? .normal)
        self.clipsToBounds = clipsToBounds ?? false
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        buttonAction()
    }
    
}
