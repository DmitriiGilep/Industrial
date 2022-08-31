//
//  Post.swift
//  Navigation
//
//  Created by DmitriiG on 15.05.2022.
//

import Foundation

public protocol PostProtocol {
    var author: String { get set }
    var description: String { get set }
    var image: String { get set }
    var likes: Int { get set }
    var views: Int { get set }
}

public struct Post: PostProtocol {
    public var author: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
}

public class PostData {

    public var postDataArray = [PostProtocol]()
    
    public func createPost(data: Post) {
        postDataArray.append(data)
    }
    
}

public var postData: PostData = {
    let post = PostData()
    post.createPost(data: Post(author: "Somebody", description: "Setting the number of lines is very important for dynamically sized cells. A label with its number of lines set to 0 will grow based on how much text it is showing. A label with number of lines set to any other number will truncate the text once it’s out of available lines", image: "One", likes: 25, views: 45))
    post.createPost(data: Post(author: "Anybody", description: "Thinking", image: "Two", likes: 60, views: 78))
    post.createPost(data: Post(author: "Humane Being", description: "Doing", image: "Three", likes: 44, views: 25))
    post.createPost(data: Post(author: "Animal", description: "Eating", image: "Four", likes: 88, views: 99))
    return post
}()
