//
//  LogInViewController.swift
//  Navigation
//
//  Created by DmitriiG on 17.04.2022.
//

import UIKit

    // MARK: - создал протокол делеката
protocol LoginViewControllerDelegate: AnyObject {
    func checker(login: String, password: String) -> Bool
}


final class LogInViewController: UIViewController {
    
    // MARK: - слабая переменная делегата
    weak var delegate: LoginViewControllerDelegate?
    
    var logInScrollView: UIScrollView = {
        var logInScroll = UIScrollView()
        logInScroll.backgroundColor = .white
        logInScroll.isScrollEnabled = true
        logInScroll.showsVerticalScrollIndicator = true
        logInScroll.translatesAutoresizingMaskIntoConstraints = false
        return logInScroll
    }()
    
    var logInContentView: UIView = {
        let logInView = UIView()
        logInView.backgroundColor = .white
        logInView.translatesAutoresizingMaskIntoConstraints = false
        return logInView
    }()
    
    let vkImageView: UIImageView = {
        let vk = UIImageView()
        let vkImage = UIImage(named: "logo")
        vk.image = vkImage
        vk.contentMode = .scaleAspectFit
        vk.translatesAutoresizingMaskIntoConstraints = false
        return vk
    }()
    
    let loginField: UIView = {
        let loginField = UIView()
        loginField.backgroundColor = .systemGray6
        loginField.layer.borderWidth = 0.5
        loginField.layer.borderColor = UIColor.lightGray.cgColor
        loginField.layer.cornerRadius = 10
        loginField.translatesAutoresizingMaskIntoConstraints = false
        return loginField
    }()
    
    let nameTextField: UITextField = {
        let nameText = UITextField()
        nameText.backgroundColor = .systemGray6
        nameText.layer.borderWidth = 0.5
        nameText.layer.borderColor = UIColor.lightGray.cgColor
        nameText.clipsToBounds = true
        nameText.layer.cornerRadius = 10
        nameText.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        nameText.textColor = UIColor.black
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        nameText.leftViewMode = .always
        nameText.leftView = spacerView
        nameText.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        nameText.tintColor = UIColor(named: "AccentColor")
        nameText.autocapitalizationType = .none
        nameText.placeholder = "Email or phone"
        nameText.translatesAutoresizingMaskIntoConstraints = false
        return nameText
    }()
    
    let passwordTextField: UITextField = {
        let passwordText = UITextField()
        passwordText.backgroundColor = .systemGray6
        //passwordText.layer.borderWidth = 0.5
        //passwordText.layer.borderColor = UIColor.lightGray.cgColor
        passwordText.textColor = UIColor.black
        passwordText.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        passwordText.tintColor = UIColor(named: "AccentColor")
        passwordText.autocapitalizationType = .none
        passwordText.placeholder = "Password"
        passwordText.isSecureTextEntry = true
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        return passwordText
    }()
    
    let logInButton: UIButton = {
        let logIn = UIButton()
        let backgroundImage = UIImage(named: "blue_pixel")
        logIn.setTitle("Log In", for: .normal)
        logIn.layer.cornerRadius = 10
        logIn.clipsToBounds = true
        logIn.backgroundColor = .blue
        logIn.titleLabel?.textColor = .white
        
        logIn.addTarget(self, action: #selector(pressLogInButton), for: .touchUpInside)
        logIn.setBackgroundImage(backgroundImage, for: .normal)
        logIn.translatesAutoresizingMaskIntoConstraints = false
        return logIn
    }()
    
    //MARK: - добавил переменные - имя пользователя и объект CurrentUserService и вставил их в инициализатор контроллера profileViewController, добавил разную инициализацию userService для debug и release
    @objc private func pressLogInButton () {
        guard let name = nameTextField.text else { return  }
#if DEBUG
        let userService = TestUserService()
#else
        let userService = CurrentUserService()
#endif
        let profileViewController = ProfileViewController(userService: userService, userName: name)
    
    //MARK: - принимаю данные ввода логина и пароля с forced unwrapping, так как значение text как минимум ""
        delegate?.checker(login: nameTextField.text!, password: passwordTextField.text!)
        
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    private func addAllViews() {
        
        self.view.addSubview(logInScrollView)
        self.logInScrollView.addSubview(logInContentView)
        self.logInContentView.addSubview(vkImageView)
        self.logInContentView.addSubview(loginField)
        self.logInContentView.addSubview(logInButton)
        self.loginField.addSubview(nameTextField)
        self.loginField.addSubview(passwordTextField)
        
    }
    
    private func setAllConstraints() {
        NSLayoutConstraint.activate(
            [
                logInScrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
                logInScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                logInScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                logInScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                
                logInContentView.topAnchor.constraint(equalTo: self.logInScrollView.topAnchor),
                logInContentView.bottomAnchor.constraint(equalTo: self.logInScrollView.bottomAnchor),
                logInContentView.leadingAnchor.constraint(equalTo: self.logInScrollView.leadingAnchor),
                logInContentView.trailingAnchor.constraint(equalTo: self.logInScrollView.trailingAnchor),
                logInContentView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                logInContentView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
                
                vkImageView.centerXAnchor.constraint(equalTo: self.logInContentView.centerXAnchor),
                vkImageView.topAnchor.constraint(equalTo: self.logInContentView.topAnchor, constant: 120),
                vkImageView.widthAnchor.constraint(equalToConstant: 100),
                vkImageView.heightAnchor.constraint(equalToConstant: 100),
                
                loginField.leadingAnchor.constraint(equalTo: self.logInContentView.leadingAnchor, constant: 16),
                loginField.trailingAnchor.constraint(equalTo: self.logInContentView.trailingAnchor, constant: -16),
                loginField.topAnchor.constraint(equalTo: self.vkImageView.bottomAnchor, constant: 120),
                loginField.heightAnchor.constraint(equalToConstant: 100),
                
                nameTextField.leadingAnchor.constraint(equalTo: self.loginField.leadingAnchor),
                nameTextField.trailingAnchor.constraint(equalTo: self.loginField.trailingAnchor),
                nameTextField.topAnchor.constraint(equalTo: self.loginField.topAnchor),
                nameTextField.heightAnchor.constraint(equalToConstant: 50),
                
                passwordTextField.leadingAnchor.constraint(equalTo: self.loginField.leadingAnchor, constant: 10),
                //           passwordTextField.trailingAnchor.constraint(equalTo: self.loginField.trailingAnchor),
                passwordTextField.bottomAnchor.constraint(equalTo: self.loginField.bottomAnchor),
                passwordTextField.heightAnchor.constraint(equalToConstant: 50),
                
                logInButton.leadingAnchor.constraint(equalTo: self.logInContentView.leadingAnchor, constant: 16),
                logInButton.trailingAnchor.constraint(equalTo: self.logInContentView.trailingAnchor, constant: -16),
                logInButton.topAnchor.constraint(equalTo: self.loginField.bottomAnchor, constant: 16),
                logInButton.heightAnchor.constraint(equalToConstant: 50),
                
            ]
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addAllViews()
        setAllConstraints()
        
        let notificationCentre = NotificationCenter.default
        notificationCentre.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCentre.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        let notificationCentre = NotificationCenter.default
        notificationCentre.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCentre.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc private func handleKeyboardShow(notification: NSNotification) {
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.logInScrollView.contentInset.bottom = keyboardFrame.height
            self.logInScrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0,bottom: keyboardFrame.height, right: 0)
        }
    }
    
    @objc private func handleKeyboardHide(notification: NSNotification) {
        self.logInScrollView.contentInset.bottom = .zero
        self.logInScrollView.verticalScrollIndicatorInsets = .zero
    }
}
