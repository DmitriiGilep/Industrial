//
//  InfoViewController.swift
//  Navigation
//
//  Created by DmitriiG on 19.02.2022.
//

import UIKit

final class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // поменял фон и имя
        title = "Info"
        view.backgroundColor = .cyan

        //создал кнопку, назначил ей вывод AlertView
        // переинициализировал кнопку при помощи CustomButton
        let button = CustomButton(
            title: (name: "Alert", state: .normal),
            titleColor: (color: nil, state: nil),
            backgroundColor: .magenta,
            backgroundImage: (image: nil, state: nil))
        button.translatesAutoresizingMaskIntoConstraints = true
        button.frame = CGRect(x: 250, y: 170, width: 130, height: 50)
        
        view.addSubview(button)
        button.tapAction = {
            [weak self] in
            let alertView = UIAlertController(title: "Alert", message: "Don't press this button", preferredStyle: .alert)
            
            //назначил 2 действия, одно (notAccepted) с выводом в консоль сообщения well done
            let accepted = UIAlertAction(title: "Accepted", style: .default, handler: {(Accepted) in print("well done")})
            let notAccepted = UIAlertAction(title: "Did't accepted", style: .cancel, handler: {(notAccepted) in print("well done")})
            alertView.addAction(accepted)
            alertView.addAction(notAccepted)
            
            // модальный вывод
            self?.present(alertView, animated: true, completion: nil)
        }
    }
    
}
