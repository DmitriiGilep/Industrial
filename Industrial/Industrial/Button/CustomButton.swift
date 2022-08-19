//
//  CustomButton.swift
//  Industrial
//
//  Created by DmitriiG on 18.08.2022.
//

import UIKit

class CustomButton: UIButton {
    
    var tapAction: (() -> Void)?
    // = nil - значение по умолчанию
    init(
        title: (name: String, state: UIControl.State?),
        titleColor: (color: UIColor?, state: UIControl.State?),
        titleLabelColor: UIColor? = nil,
        titleFont: UIFont? = nil,
        cornerRadius: CGFloat? = nil,
        backgroundColor: UIColor? = nil,
        backgroundImage: (image: UIImage?, state: UIControl.State?),
        clipsToBounds: Bool? = nil)
    {
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
        tapAction?()
    }
    
    /*Создайте собственный класс кнопки CustomButton как дочерний класс UIButton, где:
     будет собственный инициализатор, в который передаются, к примеру, параметры title, titleColor и другие по необходимости
     замыкание, в котором вызывающий объект, контроллер или родительский UIView, определят действие по нажатию кнопки
     реализацию @objc private func buttonTapped() логично спрятать внутрь класса CustomButton
     Замените для всех экранов стандартные UIButton на вашу собственную CustomButton там, где это целесообразно. Обратите внимание, насколько ваш исходный код стал компактнее и яснее.*/
}
