//
//  FeedViewController.swift
//  Navigation
//
//  Created by DmitriiG on 14.02.2022.
//

import UIKit

final class FeedViewController: UIViewController {
    
    //MARK: - let and var
    //класс observer
    let feedModel = FeedModel()
    
    let titleForPost = "PostViewController"
    
    let guessTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        // убрал автоматические заглавные буквы
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.layer.cornerRadius = 8
        textField.placeholder = "Insert a password"
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let checkGuessButton = CustomButton(
        title: (name: "Check", state: .normal),
        titleColor: (color: nil, state: nil),
        cornerRadius: 8,
        backgroundColor: .systemMint,
        backgroundImage: (image: nil, state: nil),
        clipsToBounds: true)
    
    let showGuessResultLabel: UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle
        ]
        let attributedQuote = NSMutableAttributedString(string: "Green if true, red if false", attributes: attributes)
        attributedQuote.addAttribute(.foregroundColor, value: UIColor.green, range: NSRange(location: 0, length: 5))
        attributedQuote.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 15, length: 3))
        
        label.attributedText = attributedQuote
        label.backgroundColor = .darkGray
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // кнопка 1 для перехода на postViewController и сам переход
    let button1 = CustomButton(
        title: (name: "PostButton1", state: .normal),
        titleColor: (color: nil, state: nil),
        cornerRadius: 8,
        backgroundColor: .systemBlue,
        backgroundImage: (image: nil, state: nil))
    
    
    // кнопка 2 для перехода на postViewController и сам переход
    let button2 = CustomButton(
        title: (name: "PostButton2", state: .normal),
        titleColor: (color: nil, state: nil),
        cornerRadius: 8,
        backgroundColor: .systemPink,
        backgroundImage: (image: nil, state: nil))
    
    let buttonsForPost: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        return stack
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "FeedView"
        view.backgroundColor = .darkGray
        setup()
        // включил FeedViewController в массив observer
        feedModel.subscribe(self)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        feedModel.removeSubscriber(self)
    }
    
    //MARK: - setup and other func
    
    func setup() {
        // кнопки на стэквью
        buttonsForPost.addArrangedSubview(self.guessTextField)
        buttonsForPost.addArrangedSubview(self.checkGuessButton)
        buttonsForPost.addArrangedSubview(self.showGuessResultLabel)
        buttonsForPost.addArrangedSubview(self.button1)
        buttonsForPost.addArrangedSubview(self.button2)
        
        // стэквью на вью
        view.addSubview(buttonsForPost)
        [
            buttonsForPost.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsForPost.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonsForPost.widthAnchor.constraint(equalToConstant: 300),
            buttonsForPost.heightAnchor.constraint(equalToConstant: 300)
        ]
            .forEach({$0.isActive = true})
        
        //экшны кнопок
        button1.tapAction = {
            [weak self] in
            self?.tapPostView ()
        }
        
        button2.tapAction = {
            [weak self] in
            self?.tapPostView ()
        }
        
        // вызываю функцию observer для передачи пароля
        checkGuessButton.tapAction = {
            [weak self] in
            guard let text = self?.guessTextField.text else { return }
            self?.feedModel.transferAndCheckPassword(passwordForCheck: text)
        }
        
    }
    
    func tapPostView () {
        let postViewController = PostViewController()
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
}

extension FeedViewController: Checkable {
    
    // принимаю результат и обрабатываю - тру зеленый, фолс красный, таймер - по умолчанию
    func receiveResult(result: Bool) {
        switch result {
        case true:
            showGuessResultLabel.backgroundColor = .systemGreen
            
        case false:
            showGuessResultLabel.backgroundColor = .systemRed
            
        }
        let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            self.showGuessResultLabel.backgroundColor = .darkGray
        }
    
    }
    
    
    
    
}
