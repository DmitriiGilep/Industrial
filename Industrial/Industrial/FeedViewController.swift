//
//  FeedViewController.swift
//  Navigation
//
//  Created by DmitriiG on 14.02.2022.
//

import UIKit

class FeedViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // поменял имя и фон
        title = "FeedView"
        view.backgroundColor = .darkGray
        
        // кнопка 1 для перехода на postViewController и сам переход
        let button1 = CustomButton(
            title: (name: "Кнопка1", state: .normal),
            titleColor: (color: nil, state: nil),
            backgroundColor: .blue,
            backgroundImage: (image: nil, state: nil))
        button1.tapAction = {
            [weak self] in
            self?.tapPostView ()
        }
        
        // кнопка 2 для перехода на postViewController и сам переход
        let button2 = CustomButton(
            title: (name: "Кнопка2", state: .normal),
            titleColor: (color: nil, state: nil),
            backgroundColor: .blue,
            backgroundImage: (image: nil, state: nil))
        button2.tapAction = {
            [weak self] in
            self?.tapPostView ()
        }
                
        let buttonsForPost = UIStackView()
        buttonsForPost.axis = .vertical
        buttonsForPost.spacing = 10
        buttonsForPost.addArrangedSubview(button1)
        buttonsForPost.addArrangedSubview(button2)
        buttonsForPost.translatesAutoresizingMaskIntoConstraints = false
        buttonsForPost.distribution = .fillEqually
        view.addSubview(buttonsForPost)
        [
            buttonsForPost.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsForPost.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonsForPost.widthAnchor.constraint(equalToConstant: 300),
            buttonsForPost.heightAnchor.constraint(equalToConstant: 150)
        ]
            .forEach({$0.isActive = true})
        
    }
    
    func tapPostView () {
        let postViewController = PostViewController()
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    struct Post {
        var title: String
    }
    
    var post = Post(title: "Пост")
    
    
    
    
}
    
