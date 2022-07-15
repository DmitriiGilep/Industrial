//
//  PostViewController.swift
//  Navigation
//
//  Created by DmitriiG on 15.02.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //сделал связь с feedViewController и поставил имя PostViewController как имя структуры Post в feedViewController
        let feedViewController = FeedViewController(nibName:"feedViewController", bundle: nil)
        title = feedViewController.post.title
        view.backgroundColor = .brown
        
        //создал кнопку в bar и поставил ее в свойство, далее назначил ей переход на infoViewController
        let tabBar = UIBarButtonItem(title: "Info", style:  .plain, target: self, action: #selector(tap))
        navigationItem.rightBarButtonItem = tabBar
    }
    @objc func tap() {
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true, completion: nil)
    }
}


