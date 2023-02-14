//
//  LogInViewController.swift
//  Navigation
//
//  Created by DmitriiG on 17.04.2022.
//

import UIKit
import FirebaseAuth

protocol CheckerServiceProtocol: AnyObject {
    func checkCredentials(login: String, password: String, controller: LogInViewController, coordinator: ProfileCoordinator)
    func signUp(login: String, password: String, controller: LogInViewController, coordinator: ProfileCoordinator)
}

protocol LoginViewControllerDelegate: AnyObject {
    func checkCredentials(login: String, password: String, controller: LogInViewController, coordinator: ProfileCoordinator)
    func signUp(login: String, password: String, controller: LogInViewController, coordinator: ProfileCoordinator)
}

final class LogInViewController: UIViewController {
    
    let coordinator: ProfileCoordinator
    
    // переменная делегата со слабой ссылкой
    var delegate: LoginViewControllerDelegate?
        
    var logInScrollView: UIScrollView = {
        var logInScroll = UIScrollView()
        logInScroll.backgroundColor = CustomColors.customViewColor
        logInScroll.isScrollEnabled = true
        logInScroll.showsVerticalScrollIndicator = true
        logInScroll.translatesAutoresizingMaskIntoConstraints = false
        return logInScroll
    }()
    
    var logInContentView: UIView = {
        let logInView = UIView()
        logInView.backgroundColor = CustomColors.customViewColor
        logInView.contentMode = .top
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
        loginField.backgroundColor = CustomColors.customGray
        loginField.layer.borderWidth = 0.5
        loginField.layer.borderColor = CustomColors.customGray.cgColor
        loginField.layer.cornerRadius = 10
        loginField.translatesAutoresizingMaskIntoConstraints = false
        return loginField
    }()
    
    let nameTextField: UITextField = {
        let nameText = UITextField()
        nameText.backgroundColor = CustomColors.customGray
        nameText.layer.borderWidth = 0.5
        nameText.layer.borderColor = CustomColors.customGray.cgColor
        nameText.clipsToBounds = true
        nameText.layer.cornerRadius = 10
        nameText.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        nameText.textColor = CustomColors.customTextColor
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        nameText.leftViewMode = .always
        nameText.leftView = spacerView
        nameText.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        nameText.tintColor = UIColor(named: "AccentColor")
        nameText.autocapitalizationType = .none
        nameText.placeholder = "E-mail"
        nameText.translatesAutoresizingMaskIntoConstraints = false
        return nameText
    }()
    
    let passwordTextField: UITextField = {
        let passwordText = UITextField()
        passwordText.backgroundColor = CustomColors.customGray
        //passwordText.layer.borderWidth = 0.5
        //passwordText.layer.borderColor = UIColor.lightGray.cgColor
        passwordText.textColor = CustomColors.customTextColor
        passwordText.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        passwordText.tintColor = UIColor(named: "AccentColor")
        passwordText.autocapitalizationType = .none
        passwordText.placeholder = "password".localizable
        passwordText.isSecureTextEntry = true
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        return passwordText
    }()
    
    private lazy var logInButton = CustomButton(
        title: (name: "log_in".localizable, state: nil),
        titleColor: (color: nil, state: nil),
        titleLabelColor: CustomColors.customLabelTextColor,
        titleFont: nil,
        cornerRadius: 10,
        backgroundColor: CustomColors.customButtonColor,
        backgroundImage: (image: UIImage(named: "blue_pixel"), state: nil),
        clipsToBounds: true,
        action: { [weak self] in
            
            self!.delegate?.checkCredentials(login: self!.nameTextField.text!, password: self!.passwordTextField.text!, controller: self!, coordinator: self!.coordinator)
            
            
        })
    
    private lazy var signUpButton = CustomButton(
        title: (name: "sign_up".localizable, state: nil),
        titleColor: (color: nil, state: nil),
        titleLabelColor: CustomColors.customLabelTextColor,
        titleFont: nil,
        cornerRadius: 10,
        backgroundColor: CustomColors.customButtonColor,
        backgroundImage: (image: UIImage(named: "blue_pixel"), state: nil),
        clipsToBounds: true,
        action: { [weak self] in
            self!.delegate?.signUp(login: self!.nameTextField.text!, password: self!.passwordTextField.text!, controller: self!, coordinator: self!.coordinator)
            
        })
    
    let randomPasswordTextField: UITextField = {
        let passwordText = UITextField()
        passwordText.backgroundColor = CustomColors.customGray
        //passwordText.layer.borderWidth = 0.5
        //passwordText.layer.borderColor = UIColor.lightGray.cgColor
        passwordText.textColor = CustomColors.customTextColor
        passwordText.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        passwordText.tintColor = UIColor(named: "AccentColor")
        passwordText.autocapitalizationType = .none
        passwordText.placeholder = "random_password".localizable
        passwordText.isSecureTextEntry = true
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        return passwordText
    }()
    
    private lazy var generateRandomPasswordButton = CustomButton(
        title: (name: "generate_random_password".localizable, state: nil),
        titleColor: (color: nil, state: nil),
        titleLabelColor: CustomColors.customLabelTextColor,
        titleFont: nil,
        cornerRadius: 10,
        backgroundColor: CustomColors.customButtonColor,
        backgroundImage: (image: UIImage(named: "blue_pixel"), state: nil),
        clipsToBounds: true,
        action: {
            [weak self] in
            let generateRandomPassword = GenerateRandomPassword()
            self?.randomPasswordTextField.text = generateRandomPassword.randomPassword()
        })
    
    private lazy var bruteForceRandomPasswordButton = CustomButton(
        title: (name: "hack_use_random_password".localizable, state: nil),
        titleColor: (color: nil, state: nil),
        titleLabelColor: CustomColors.customLabelColor,
        titleFont: nil,
        cornerRadius: 10,
        backgroundColor: CustomColors.customButtonColor,
        backgroundImage: (image: nil, state: nil),
        clipsToBounds: true,
        action: {
            [weak self] in
            let bruteForce = BruteForce()
            let queueForbruteForce = DispatchQueue(label: "BruteForce")
            self?.activityIndicatior.startAnimating()
            var password = self?.randomPasswordTextField.text
            self?.generateRandomPasswordButton.isEnabled = false
            queueForbruteForce.async {
                let unLockedPassword = bruteForce.bruteForce(passwordToUnlock: password!)
                DispatchQueue.main.async {
                    self?.activityIndicatior.stopAnimating()
                    self?.passwordTextField.text = unLockedPassword
                    self?.passwordTextField.isSecureTextEntry = false
                    self?.randomPasswordTextField.isSecureTextEntry = false
                    _ = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                        self?.passwordTextField.isSecureTextEntry = true
                        self?.randomPasswordTextField.isSecureTextEntry = true
                        self?.generateRandomPasswordButton.isEnabled = true
                        
                    }
                }
            }
        })
    
    
    private let activityIndicatior: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.color = CustomColors.customLabelColor
        //       activity.isHidden = false
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    //MARK: - init
    init(coordinator: ProfileCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle:  nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addAllViews() {
        view.addSubview(logInScrollView)
        logInScrollView.addSubview(logInContentView)
        logInContentView.addSubview(vkImageView)
        logInContentView.addSubview(loginField)
        logInContentView.addSubview(logInButton)
        logInContentView.addSubview(signUpButton)
        loginField.addSubview(nameTextField)
        loginField.addSubview(passwordTextField)
        logInContentView.addSubview(randomPasswordTextField)
        logInContentView.addSubview(generateRandomPasswordButton)
        logInContentView.addSubview(bruteForceRandomPasswordButton)
        passwordTextField.addSubview(activityIndicatior)
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
                // не скролится по ширине в этом случае
                logInContentView.widthAnchor.constraint(equalTo: self.logInScrollView.widthAnchor),
                // высота не нужна, если ставить bottomAnchor для нижней вью, чтобы contentView настраивалось по размерам своего контента
                //   logInContentView.heightAnchor.constraint(equalToConstant: 1000),
                
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
                passwordTextField.trailingAnchor.constraint(equalTo: self.loginField.trailingAnchor),
                passwordTextField.bottomAnchor.constraint(equalTo: self.loginField.bottomAnchor),
                passwordTextField.heightAnchor.constraint(equalToConstant: 50),
                
                activityIndicatior.centerYAnchor.constraint(equalTo: self.passwordTextField.centerYAnchor),
                activityIndicatior.centerXAnchor.constraint(equalTo: self.passwordTextField.centerXAnchor),
                
                logInButton.leadingAnchor.constraint(equalTo: self.logInContentView.leadingAnchor, constant: 16),
                logInButton.trailingAnchor.constraint(equalTo: self.logInContentView.trailingAnchor, constant: -16),
                logInButton.topAnchor.constraint(equalTo: self.loginField.bottomAnchor, constant: 16),
                logInButton.heightAnchor.constraint(equalToConstant: 50),
                
                signUpButton.leadingAnchor.constraint(equalTo: self.logInContentView.leadingAnchor, constant: 16),
                signUpButton.trailingAnchor.constraint(equalTo: self.logInContentView.trailingAnchor, constant: -16),
                signUpButton.topAnchor.constraint(equalTo: self.logInButton.bottomAnchor, constant: 16),
                signUpButton.heightAnchor.constraint(equalToConstant: 50),
                
                randomPasswordTextField.leadingAnchor.constraint(equalTo: self.logInContentView.leadingAnchor, constant: 16),
                randomPasswordTextField.trailingAnchor.constraint(equalTo: self.logInContentView.trailingAnchor, constant: -16),
                randomPasswordTextField.topAnchor.constraint(equalTo: self.signUpButton.bottomAnchor, constant: 16),
                randomPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
                
                generateRandomPasswordButton.leadingAnchor.constraint(equalTo: self.logInContentView.leadingAnchor, constant: 16),
                generateRandomPasswordButton.trailingAnchor.constraint(equalTo: self.logInContentView.trailingAnchor, constant: -16),
                generateRandomPasswordButton.topAnchor.constraint(equalTo: self.randomPasswordTextField.bottomAnchor, constant: 16),
                generateRandomPasswordButton.heightAnchor.constraint(equalToConstant: 50),
                
                bruteForceRandomPasswordButton.leadingAnchor.constraint(equalTo: self.logInContentView.leadingAnchor, constant: 16),
                bruteForceRandomPasswordButton.trailingAnchor.constraint(equalTo: self.logInContentView.trailingAnchor, constant: -16),
                bruteForceRandomPasswordButton.topAnchor.constraint(equalTo: self.generateRandomPasswordButton.bottomAnchor, constant: 16),
                bruteForceRandomPasswordButton.heightAnchor.constraint(equalToConstant: 30),
                // нужно ставить bottomAnchor для нижней вью, чтобы contentView настраивалось по размерам своего контента
                bruteForceRandomPasswordButton.bottomAnchor.constraint(equalTo: logInContentView.bottomAnchor, constant: -16)
            ]
        )
    }
    
    override func viewDidLoad() {
        view.backgroundColor = CustomColors.customViewColor
        addAllViews()
        setAllConstraints()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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

