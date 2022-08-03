//
//  User.swift
//  Industrial
//
//  Created by DmitriiG on 01.08.2022.
//

import Foundation
import UIKit

final class User {
    var name: String
    var avatar: UIImage
    var status: String
    
    init(name: String, avatar: UIImage, status: String) {
        self.name = name
        self.avatar = avatar
        self.status = status
    }
}

protocol UserService {
    
    func userInfo(name: String) -> User?
    
}

class CurrentUserService: UserService {
    
    var user = User(name: "Dmitrii", avatar: UIImage(named: "Avatar.jpeg")!, status: "Thinking")
    
    func userInfo(name: String) -> User? {
        if name == user.name  {return user}
        else {return nil}
    }
}

class TestUserService: UserService {
    
    var user = User(name: "Guest", avatar: UIImage(named: "GuestAvatar.jpeg")!, status: "Guest")
    
    func userInfo(name: String) -> User? {
        if name == user.name  {return user}
        else {return nil}
    }
}

/*
 Добавить класс User для хранения информации о пользователе: полное имя, аватар, статус.
 Добавить протокол UserService с функцией, которая принимает имя пользователя и возвращает объект класса User.
 Добавить класс CurrentUserService, который поддерживает протокол UserService. Класс должен хранить объект класса User и возвращать его в реализации протокола, если переданное имя соответствует имени пользователя.
 
 В классе ProfileViewController добавить свойство с типом UserService и инициализатор, который принимает объект UserService и имя пользователя, введённое на экране LogInViewController. При инициализации объекта ProfileViewController передать объект CurrentUserService.
 В классе ProfileViewController добавить получение пользователя из объекта UserService и отображение информации из объекта User.
 Добавить класс TestUserService, который поддерживает протокол UserService. Класс должен хранить объект класса User с тестовыми данными и возвращать его в реализации протокола.
 При инициализации объекта ProfileViewController добавить проверку Debug сборки с помощью флага компиляции #DEBUG и передавать объект TestUserService. Для Release сборок оставить передачу объекта CurrentUserService.
 */
