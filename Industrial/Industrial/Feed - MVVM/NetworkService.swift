//
//  NetworkService.swift
//  Industrial
//
//  Created by DmitriiG on 10.10.2022.
//

import Foundation
import UIKit


// enum с url
enum AppConfiguration {
    case ref1
    case ref2
    case ref3
    var url: URL? {
        switch self {
        case .ref1:
            return URL(string: "https://swapi.dev/api/people/8")
        case .ref2:
            return URL(string: "https://swapi.dev/api/starships/3")
        case .ref3:
            return URL(string: "https://swapi.dev/api/planets/5")
        }
    }
}

struct NetworkService {
    
    static func request (with config: AppConfiguration) {
        guard let url = config.url else {
            print ("URL не найден")
            return
        }
        
        
        let task  = URLSession.shared.dataTask(with: url) { data, response, error in

            if let data = data {
                print("-----------------------data-------------------------")
                print("🤓 \(String(data: data, encoding: .utf8))")
            }
            print("------------------response.allHeaderFields-------------------------")
            print("😂 \((response as! HTTPURLResponse).allHeaderFields)")
            print("------------------response.statusCode------------------------------")
            print("😂 \((response as! HTTPURLResponse).statusCode)")
            print("------------------error.localizedDescription------------------------")
            print("😒 \(error?.localizedDescription)")
            print("------------------error.debugDescription---------------------------")
            print("😒 \(error.debugDescription)")

        }
        task.resume()
    }
}



