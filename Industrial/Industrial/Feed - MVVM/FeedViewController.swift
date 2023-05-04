//
//  FeedViewController.swift
//  Navigation
//
//  Created by DmitriiG on 14.02.2022.
//

import UIKit
import UserNotifications

final class FeedViewController: UIViewController {
    
    //MARK: - let and var
    
    //#if DEBUG
    //    // Protocol Observer, класс observer
    //    let feedModel = FeedModel()
    //#endif
      
    
    // в sceneDelegate: UIApplication.shared.connectedScenes.firs?.delegate as? SceneDelegate, appDelegate: UIApplication.shared.delegate as? AppDelegate
    var appConfiguration = (UIApplication.shared.connectedScenes.first as? SceneDelegate)?.appConfiguration
    
    var coordinator: FeedCoordinatorProtocol? = nil
    var feedViewModel: FeedViewModel? = nil
    
    private var timer0: Timer?
    private var timer1: Timer?
    private var timer2: Timer?
    
    let titleForPost = "postViewController".localizable
    
    let reminderLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.label
        label.textColor = UIColor.lightText
        label.text = "password_prompt".localizable
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.label
        label.textColor = UIColor.lightText
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let guessTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = CustomColors.customViewColor
        // убрал автоматические заглавные буквы
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.layer.cornerRadius = 8
        textField.placeholder = "insert_password".localizable
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var checkGuessButton = CustomButton(
        title: (name: "check".localizable, state: .normal),
        titleColor: (color: nil, state: nil),
        cornerRadius: 8,
        backgroundColor: CustomColors.customButtonMint,
        backgroundImage: (image: nil, state: nil),
        clipsToBounds: true,
        action: {
            [weak self] in
            
            //#if DEBUG
            //            // Protocol Observer
            //            guard let text = self?.guessTextField.text else { return }
            //            self?.feedModel.transferAndCheckPassword(passwordForCheck: text)
            //            _ = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            //                self?.showGuessResultLabel.backgroundColor = .darkGray
            //            }
            //
            //#else
            
            self?.feedViewModel?.changeState(interfaceEvent: .checkGuessButtonPressed, controller: self!)
            
            //#endif
        })
    
    let showGuessResultLabel: UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle
        ]
        let attributedQuote = NSMutableAttributedString(string: "password_prompt_descript".localizable, attributes: attributes)
        attributedQuote.addAttribute(.foregroundColor, value: UIColor.green, range: NSRange(location: 0, length: 5))
        attributedQuote.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 15, length: 3))
        
        label.attributedText = attributedQuote
        label.backgroundColor = .systemGray
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // кнопка 1 для перехода на postViewController и сам переход
    lazy var button1 = CustomButton(
        title: (name: "postButton1".localizable, state: .normal),
        titleColor: (color: nil, state: nil),
        cornerRadius: 8,
        backgroundColor: CustomColors.customButtonBlue,
        backgroundImage: (image: nil, state: nil),
        action: {
            [weak self] in
            self?.buttonGoToPostViewControllerPressed()
        })
    
    // кнопка для перехода на mapViewController и сам переход
    lazy var button2 = CustomButton(
        title: (name: "mapView".localizable, state: .normal),
        titleColor: (color: nil, state: nil),
        cornerRadius: 8,
        backgroundColor: CustomColors.customButtonPink,
        backgroundImage: (image: nil, state: nil),
        action: {
            [weak self] in
            self?.buttonGoToMapViewControllerPressed()
        })
    
    let buttonsForPost: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        return stack
    }()
    
    //MARK: - init
//    init(coordinator: FeedCoordinatorProtocol, model: FeedViewModel) {
//        self.coordinator = coordinator
//        self.feedViewModel = model
//        super.init(nibName: nil, bundle:  nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "feedView".localizable
        view.backgroundColor = .darkGray
        setup()
        bindViewModel()
      //  remindPassword()
        
        // вызывают статический метод request класса NetworkService
        // NetworkService.request(with: appConfiguration!)
        
        //        // включил FeedViewController в массив observer
        //      #if DEBUG
        //              feedModel.subscribe(self)
        //      #endif
        
    }
    
    //MARK: - viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //  feedModel.removeSubscriber(self)
    }
    
    //MARK: - setup and other func
    func setup() {
        // кнопки на стэквью
        buttonsForPost.addArrangedSubview(self.guessTextField)
        buttonsForPost.addArrangedSubview(self.checkGuessButton)
        buttonsForPost.addArrangedSubview(self.showGuessResultLabel)
        buttonsForPost.addArrangedSubview(self.button1)
        buttonsForPost.addArrangedSubview(self.button2)
        view.addSubview(reminderLabel)
        view.addSubview(timerLabel)
        
        // стэквью на вью
        view.addSubview(buttonsForPost)
        [
            buttonsForPost.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsForPost.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonsForPost.widthAnchor.constraint(equalToConstant: 300),
            buttonsForPost.heightAnchor.constraint(equalToConstant: 300),
            
            reminderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reminderLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            reminderLabel.widthAnchor.constraint(equalToConstant: 250),
            reminderLabel.heightAnchor.constraint(equalToConstant: 40),
            
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            timerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            timerLabel.widthAnchor.constraint(equalToConstant: 30),
            timerLabel.heightAnchor.constraint(equalToConstant: 30),
            
        ]
            .forEach({$0.isActive = true})
        
        view.bringSubviewToFront(reminderLabel)
        reminderLabel.isHidden = true
    }
    
    func buttonGoToPostViewControllerPressed() {
        self.feedViewModel?.changeState(interfaceEvent: .buttonGoToPostViewControllerPressed, controller: self)
        
    }
    
    func buttonGoToMapViewControllerPressed() {
        self.feedViewModel?.changeState(interfaceEvent: .buttonGoToMapViewControllerPressed, controller: self)
        
    }
    
    private func remindPassword() {
        var count = 0
        
        timer0 = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer0 in
            count += 1
            self.timerLabel.text = String(count)
            
            if self.checkGuessButton.isHighlighted {
                self.timer0?.invalidate()
                self.timer0 = nil
            }
            
            if count == 15 {
                self.timer0?.invalidate()
                self.timer0 = nil
            }
        }
        
        timer1 = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer1 in
            self.reminderLabel.isHidden = false
            self.timer1?.invalidate()
            self.timer1 = nil
        }
        
        timer2 = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { timer2 in
            self.reminderLabel.isHidden = true
            self.timer2?.invalidate()
            self.timer2 = nil
        }
    }
    
    private func bindViewModel() {
        feedViewModel?.processInterfaceEvents = {
            [weak self] state in
            switch state {
            case .resultGuessCheckTrue:
                self?.showGuessResultLabel.backgroundColor = .systemGreen
                _ = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                    self?.showGuessResultLabel.backgroundColor = .darkGray}
            case .resultGuessCheckFalse:
                self?.showGuessResultLabel.backgroundColor = .systemRed
                _ = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                    self?.showGuessResultLabel.backgroundColor = .darkGray
                }
            case .goToPostViewController:
                self?.coordinator?.postViewController()
                
            case .goToMapViewController:
                self?.coordinator?.mapViewController()
                
            }
        }
    }
}

//#if DEBUG
//// Protocol Observer
//extension FeedViewController: Checkable {
//    
//    // принимаю результат и обрабатываю - тру зеленый, фолс красный, таймер - по умолчанию
//    func receiveResult(result: Bool) {
//        switch result {
//        case true:
//            showGuessResultLabel.backgroundColor = .systemGreen
//            
//        case false:
//            showGuessResultLabel.backgroundColor = .systemRed
//            
//        }
//    }
//}
//#endif
