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
        let button1 = UIButton()
        button1.setTitle("Кнопка1", for: .normal)
        button1.backgroundColor = .blue
        view.addSubview(button1)
        button1.addTarget(self, action: #selector(tapPostView), for: .touchUpInside)
        
        // кнопка 2 для перехода на postViewController и сам переход
        let button2 = UIButton()
        button2.setTitle("Кнопка2", for: .normal)
        button2.backgroundColor = .blue
        view.addSubview(button2)
        button2.addTarget(self, action: #selector(tapPostView), for: .touchUpInside)
        
                
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
    let postViewController = PostViewController()
    @objc func tapPostView () {
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    struct Post {
        var title: String
    }
    
    var post = Post(title: "Пост")
    
    
    
    
}
    
