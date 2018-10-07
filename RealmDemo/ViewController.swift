//
//  ViewController.swift
//  RealmDemo
//
//  Created by ADELU ABIDEEN ADELEYE on 10/7/18.
//  Copyright © 2018 Spantom Technologies Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var objectsArray = [String]()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 80
        return tableView
    }()
    
    
    var addButton = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupTableView()
    }
    
    func setup() {
        view.backgroundColor = .white
        navigationItem.title = "Things"
        navigationController?.navigationBar.prefersLargeTitles = true
        addButton = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addNewItem))
        navigationItem.rightBarButtonItem = addButton
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyCell.self, forCellReuseIdentifier: MyCell.reuseIdentifier)
        view.addSubview(tableView)
        
        tableView.setAnchor(top: view.topAnchor, topPad: 0, bottom: view.bottomAnchor, bottomPad: 0, left: view.leftAnchor, leftPad: 0, right: view.rightAnchor, rightPad: 0, height: 0, width: 0)
    }
    
    @objc func addNewItem() {
        let alertVC = UIAlertController(title: "Add New Item", message: "What do you want to do?", preferredStyle: .alert)
        alertVC.addTextField(configurationHandler: nil)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) -> Void in
            let myTextField = (alertVC.textFields?.first)! as UITextField
            self.objectsArray.append(myTextField.text!)
            self.tableView.insertRows(at: [IndexPath(row: self.objectsArray.count-1, section: 0)], with: .automatic)
        }
        alertVC.addAction(addAction)
        alertVC.addAction(cancelAction)
        
        present(alertVC, animated: true, completion: nil)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyCell.reuseIdentifier, for: indexPath) as! MyCell
        cell.todoImageView.image = UIImage(named: "todo")
        cell.todoLabel.text = objectsArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.objectsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

class MyCell: UITableViewCell {
    
    static let reuseIdentifier = "cell"
    
    let todoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let todoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(todoImageView)
        addSubview(todoLabel)
        
        todoImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        todoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        todoImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        todoImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        todoLabel.leftAnchor.constraint(equalTo: todoImageView.rightAnchor, constant: 10).isActive = true
        todoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
}

