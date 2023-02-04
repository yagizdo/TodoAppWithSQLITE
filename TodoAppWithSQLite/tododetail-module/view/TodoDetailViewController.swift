//
//  TodoDetailViewController.swift
//  TodoAppWithSQLite
//
//  Created by Yılmaz Yağız Dokumacı on 4.02.2023.
//

import UIKit

class TodoDetailViewController: UIViewController {
    @IBOutlet weak var todoTitleTF: UITextField!
    
    @IBOutlet weak var todoTitleDesc: UITextField!
    
    var todoDetailPresentDelegate:ViewToPresenterTodoDetailProtocol?
    
    var todo:Todo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let t = todo {
            todoTitleTF.text = t.todo_title
            todoTitleDesc.text = t.todo_description ?? ""
        }
        
        TodoDetailRouter.createModule(ref: self)
    }
    
    
    @IBAction func updateTodoButton(_ sender: Any) {
        if let todoTitle = todoTitleTF.text, let todoDescription = todoTitleDesc.text, let t = todo {
            todoDetailPresentDelegate?.updateTodo(todoID: t.todo_id!, todoTitle: todoTitle, todoDescription: todoDescription)
            navigationController?.popViewController(animated: true)
        }
    }
    
}
