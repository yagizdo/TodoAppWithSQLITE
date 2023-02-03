//
//  AddTodoViewController.swift
//  TodoAppWithSQLite
//
//  Created by Yılmaz Yağız Dokumacı on 3.02.2023.
//

import UIKit

class AddTodoCategoriesCell : UITableViewCell {
    
}

class AddTodoViewController: UIViewController {
    
    @IBOutlet weak var todoTitleTF: UITextField!
    
    @IBOutlet weak var todoDescriptionTF: UITextField!
    
    @IBOutlet weak var selectCategoryBTN: UIButton!
    
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    
    var categories = [Category]()
    
    var selectedCategory : Category?
    
    var todo:Todo?

    var addTodoPresentDelegate:ViewToPresenterAddTodoProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddTodoCategoriesCell.self, forCellReuseIdentifier: "addTodoCategoriesCell")
        
        AddTodoRouter.createModule(ref: self)
        
        addTodoPresentDelegate?.getCategories()
    }
    
    // Create transparent view for list
    func addTransparentView(frames:CGRect) {
        
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        // Table view
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width , height: 0)
        self.view.addSubview(tableView)
        
        tableView.layer.cornerRadius = 5
        
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width , height: CGFloat(self.categories.count * 50))
        },completion: nil )
    }
    
    // Remove transparent view
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width , height: 0)
        },completion: nil )
    }
    
    func showEmptyAlert(title:String,message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    
    @IBAction func onClickAddTodoBtn(_ sender: Any) {
        
        
        if let todo_title = todoTitleTF.text, let todo_description = todoDescriptionTF.text {
            if todo_title.isEmpty {
                showEmptyAlert(title: "Please write title", message: "Title can not be empty")
            } else if selectedCategory == nil {
                showEmptyAlert(title: "Please select category", message: "Category can not be empty")
            } else {
                addTodoPresentDelegate?.addTodo(todoTitle: todo_title, todoDescription: todo_description, categoryID: selectedCategory!.category_id!)
            }
        }
        
    }
    
    
    // Select category button
    @IBAction func onClickSelectCategoryBTN(_ sender: Any) {
        selectedButton = selectCategoryBTN
        addTransparentView(frames: selectCategoryBTN.frame)
    }
}

// Extension for table view
extension AddTodoViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addTodoCategoriesCell", for: indexPath)
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.category_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        selectCategoryBTN.setTitle("Selected Category : \(category.category_name!)", for: .normal)
        self.selectedCategory = category
        removeTransparentView()
    }
    
}

extension AddTodoViewController : PresenterToViewAddTodoProtocol {
    func sendDataToView(categories: [Category]) {
        self.categories = categories
    }
}
