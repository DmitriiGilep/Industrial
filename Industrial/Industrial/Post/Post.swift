//
//  Post.swift
//  Navigation
//
//  Created by DmitriiG on 15.05.2022.
//

import Foundation

public protocol PostProtocol {
    var author: String? { get set }
    var descriptionOfPost: String? { get set }
    var image: String? { get set }
    var likes: Int16 { get set }
    var views: Int16 { get set }
}

public struct Post: PostProtocol {
    public var author: String?
    public var descriptionOfPost: String?
    public var image: String?
    public var likes: Int16
    public var views: Int16
}

public class PostData {

    public var postDataArray = [PostProtocol]()
    
    public func createPost(data: Post) {
        postDataArray.append(data)
    }
    
}

public var postData: PostData = {
    let post = PostData()
    post.createPost(data: Post(author: "Somebody", descriptionOfPost: "Setting the number of lines is very important for dynamically sized cells. A label with its number of lines set to 0 will grow based on how much text it is showing. A label with number of lines set to any other number will truncate the text once it’s out of available lines", image: "One", likes: 25, views: 45))
    post.createPost(data: Post(author: "Anybody", descriptionOfPost: "Thinking", image: "Two", likes: 60, views: 78))
    post.createPost(data: Post(author: "Humane Being", descriptionOfPost: "Doing", image: "Three", likes: 44, views: 25))
    post.createPost(data: Post(author: "Animal", descriptionOfPost: "Eating", image: "Four", likes: 88, views: 99))
    return post
}()
