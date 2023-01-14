//
//  FavoritesCoreData.swift
//  Industrial
//
//  Created by DmitriiG on 08.01.2023.
//

import Foundation
import CoreData

final class FavoritesCoreData {
    
    static let shared = FavoritesCoreData()
    
    var posts: [PostFav] = []
    
    private init() {
        loadPosts()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "Industrial")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func loadPosts() {
        let request = PostFav.fetchRequest()
        let posts = (try? persistentContainer.viewContext.fetch(request)) ?? []
        self.posts = posts

    }

    func addPost(post: PostProtocol) {
        var postFav = PostFav(context: persistentContainer.viewContext)
        postFav.author = post.author
        postFav.descriptionOfPost = post.descriptionOfPost
        postFav.image = post.image
        postFav.likes = post.likes
        postFav.views = post.views
        saveContext()
        loadPosts()
    }
    
    func deletePost(post: PostFav) {
        persistentContainer.viewContext.delete(post)
        saveContext()
        loadPosts()
    }
    
}
