//
//  InfoViewModel.swift
//  Industrial
//
//  Created by DmitriiG on 30.08.2022.
//

import Foundation

final class InfoViewModel {
    
    var title: String = "fetching data in process" {
        didSet {
            processInterfaceEvents?(.processUrlRequest)
        }
    }
    
    var orbitalPeriod: String = "fetching data in process" {
        didSet {
            processInterfaceEvents?(.processUrlRequest2)
        }
    }
    
    var residentsUrl: [String] = []
    var residentsName: [String] = [] {
        didSet {
            processInterfaceEvents?(.processUrlRequest3)
        }
    }
    
    enum InterFaceEvents {
        case buttonPresentAlertViewTapped
        case urlRequest
        case urlRequest2
        case urlRequest3


    }
    
    enum State {
        case goToAlertView
        case processUrlRequest
        case processUrlRequest2
        case processUrlRequest3

        
    }
    
    var processInterfaceEvents: ((State) -> Void)?
    
    private(set) var state: State = .goToAlertView{
        didSet{
            processInterfaceEvents?(state)
        }
    }
    
    func changeState(interFaceEvent: InterFaceEvents, controller: InfoViewController) {
        switch interFaceEvent {
        case .buttonPresentAlertViewTapped:
            state = .goToAlertView
        case .urlRequest:
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/9") else {
                print("error")
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    print("error")
                    return
                }
                guard let data = data else {
                    print("error")
                    return
                }
                
                do {
                    let object = try JSONSerialization.jsonObject(with: data)
                    if let dictionary = object as? [String: Any] {
                        let sentData = try JSONSerialization.data(withJSONObject: dictionary)
                        
                        DispatchQueue.main.async {
                            self.title = dictionary["title"] as! String
                        }
                    }
                } catch {
                    print("error")
                    return
                }
            }
            task.resume()
            state = .processUrlRequest
            
        case .urlRequest2:
            guard let url = URL(string: "https://swapi.dev/api/planets/1") else {
                print("error2url")
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    print("error2task")
                    return
                }
                guard let data = data else {
                    print("error2date")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
               //     decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let tatooine = try decoder.decode(Tatooine.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.orbitalPeriod = tatooine.orbitalPeriod
                        self.residentsUrl = tatooine.residents
                    }
                    
                    } catch {
                    print("error2decoder")
                    return
                }
                
            }
            task.resume()
            state = .processUrlRequest2
            
        case .urlRequest3:
            for ref in residentsUrl {
                guard let url = URL(string: ref) else {
                    print("error3url")
                    return
                }
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard error == nil else {
                        print("error3task")
                        return
                    }
                    guard let data = data else {
                        print("error3date")
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let resident = try decoder.decode(Residents.self, from: data)
                        
                        DispatchQueue.main.async {
                            self.residentsName.append(resident.name)
                        }
                        
                        } catch {
                        print("error3decoder")
                        return
                    }
                    
                }
                task.resume()
                state = .processUrlRequest3
            }
            
        }
        
    }
}
