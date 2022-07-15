//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by DmitriiG on 02.03.2022.
//

import UIKit


final class ProfileHeaderView: UIView {
    
    let fullNameLabel: UILabel = {
        let fullName = UILabel()
        fullName.text = "Hipster Guy"
        fullName.textColor = UIColor.black
        fullName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        fullName.textAlignment = .center
        fullName.translatesAutoresizingMaskIntoConstraints = false
        return fullName
    }()
    
    let statusLabel: UILabel = {
        let status = UILabel()
        status.textColor = UIColor.gray
        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        status.textAlignment = .center
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    let statusTextField: UITextField = {
        let statusText = UITextField()
        statusText.layer.borderWidth = 1
        statusText.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        statusText.layer.cornerRadius = 12
        statusText.layer.backgroundColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        statusText.placeholder = "Set your status"
        statusText.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        statusText.translatesAutoresizingMaskIntoConstraints = false
        return statusText
    }()
    
    private var statusText: String = ""
    
    let setStatusButton: UIButton = {
        let setStatus = UIButton()
        setStatus.setTitle("Set status", for: .normal)
        setStatus.backgroundColor = .blue
        setStatus.addTarget(self, action: #selector(pressSetButton), for: .touchUpInside)
        setStatus.layer.cornerRadius = 4
        setStatus.translatesAutoresizingMaskIntoConstraints = false
        return setStatus
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUP()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) {

        statusTextField.textColor = UIColor.black
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusTextField.textAlignment = .natural
        statusTextField.textAlignment = .center
        if let textExist = statusTextField.text {
            statusText = textExist
        }
        return
    }
    
    @objc private func pressSetButton (_ textField: UITextField) {
        statusLabel.text = statusText
    }
    
    private func setUP() {
        
        self.addSubview(fullNameLabel)
        self.addSubview(setStatusButton)
        self.addSubview(statusLabel)
        self.addSubview(statusTextField)

        NSLayoutConstraint.activate([
                   
            fullNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 136),
            fullNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            setStatusButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 172),
            setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 40),
            
            statusLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 136),
            statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusLabel.heightAnchor.constraint(equalToConstant: 20),
            statusLabel.bottomAnchor.constraint(equalTo: self.setStatusButton.topAnchor, constant: -74),
            
            statusTextField.topAnchor.constraint(equalTo: self.statusLabel.bottomAnchor, constant: 5),
            statusTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 136),
            statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

