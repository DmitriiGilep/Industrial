//
//  FaboritesTableViewController.swift
//  Industrial
//
//  Created by DmitriiG on 08.01.2023.
//

import UIKit

final class FavoritesTableViewController: UITableViewController {
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Избранное не содержит постов"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        
        tableView.estimatedRowHeight = 310
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows: Int
        if FavoritesCoreData.shared.posts.isEmpty {
            emptyLabel.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
            tableView.backgroundView = emptyLabel
            tableView.separatorStyle = .none
            numberOfRows = 0
        } else {
            numberOfRows = FavoritesCoreData.shared.posts.count
        }
        return numberOfRows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: PostTableViewCell.self),
            for: indexPath) as? PostTableViewCell
        else {
            return UITableViewCell()
        }
        
        
        let data = FavoritesCoreData.shared.posts[indexPath.row]
        cell.post = data
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let post = FavoritesCoreData.shared.posts[indexPath.row]
            FavoritesCoreData.shared.deletePost(post: post)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

