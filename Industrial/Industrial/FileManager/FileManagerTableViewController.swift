//
//  FileManagerTableViewController.swift
//  Industrial
//
//  Created by DmitriiG on 29.10.2022.
//

import UIKit

final class FileManagerTableViewController: UITableViewController {
    
    var imageToSave: UIImage?
    private let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    var urlArray: [URL] {
        return (try? FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)) ?? []
    }
    
    private func setUpAndLaunchAlertController() {
        let alertController = UIAlertController(title: "Save a picture", message: "Choose the name of the picture", preferredStyle: .alert)
        alertController.addTextField { text in
            text.placeholder = "Insert the filename"
        }
        let alertActionSave = UIAlertAction(title: "Save", style: .default) { UIAlertAction in
            self.savePhoto(alertController: alertController)
        }
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .default)
        alertController.addAction(alertActionSave)
        alertController.addAction(alertActionCancel)
        self.present(alertController, animated: true)
    }
    
    private func savePhoto(alertController: UIAlertController) {
        guard let imageName = alertController.textFields![0].text else {return}
        let imageURL = url.appendingPathComponent(imageName)
        var unique = true
        urlArray.forEach({ URL in
            if imageURL == URL {
                unique = false
            }
        })
        guard unique else {
            let alert = UIAlertController(title: "Ошибка", message: "Такое имя уже существует", preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(actionOk)
            self.present(alert, animated: true)
            return
            
        }
        guard let image = imageToSave else {return}
        if let imageJPEG = image.jpegData(compressionQuality: 0.8) {
            do {
                try imageJPEG.write(to: imageURL)
                tableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func setUpPicker() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @objc func addPhoto() {
        setUpPicker()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.navigationItem.title = "Directory"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить фотографию", style: .done, target: self, action: #selector(addPhoto))
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = urlArray[indexPath.row].lastPathComponent
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try? FileManager.default.removeItem(at: urlArray[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

extension FileManagerTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) { // метод срабатывает после окончания выбора
        
        guard let image = info[.editedImage] as? UIImage else { return } // .editedImage так как picker.allowsEditing = true
        imageToSave = image
        dismiss(animated: true)
        setUpAndLaunchAlertController()
    }
}
