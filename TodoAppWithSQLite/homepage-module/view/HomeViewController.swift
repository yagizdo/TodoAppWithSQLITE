//
//  ViewController.swift
//  TodoAppWithSQLite
//
//  Created by Yılmaz Yağız Dokumacı on 1.02.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    @IBOutlet weak var todosTableView: UITableView!
    
    @IBOutlet weak var todosListTitleLabel: UILabel!
    
    var todos = [Todo]()
    
    var categories = [Category]()
    
    var selectedCategoryIndex:Int = 0
    
    var homeViewPresenterDelegate: ViewToPresenterHomeViewProtocol?
    
    
    
    // When the application runs for the first time, we make it copy our sqlite file into the phone.
    func copyDatabase() {
        let bundlePath = Bundle.main.path(forResource: "todohomework", ofType: ".db")
        let destinationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let copyPath = URL(fileURLWithPath: destinationPath).appendingPathComponent("todohomework.db")
        let fm = FileManager.default
        if fm.fileExists(atPath: copyPath.path) {
            print("The database already exists")
        } else {
            do {
                try fm.copyItem(atPath: bundlePath!, toPath: copyPath.path)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Categories
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        
        // Todos
        todosTableView.delegate = self
        todosTableView.dataSource = self
        todosTableView.separatorStyle = .none
        changeCategoriesCellDesign()
        
        copyDatabase()
        
        HomeViewRouter.createModule(ref: self)
        
        homeViewPresenterDelegate?.getCategories()
        homeViewPresenterDelegate?.getTodos(categoryID: 1)
        if categories.isEmpty {
            todosListTitleLabel.text = "Daily Todos"
        } else {
            todosListTitleLabel.text = "\(categories[0].category_name!) Todos"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homeViewPresenterDelegate?.getTodos(categoryID: selectedCategoryIndex)
    }
    
    
    @IBAction func addCategoryBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Add Category", message: "Please Write Category Name", preferredStyle: .alert)
        alert.addTextField() {
            textfield in
            textfield.placeholder = "Category Name"
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)
        
        let okayButton = UIAlertAction(title: "Add Category", style: .default) {
         action in
            if var categoryName = alert.textFields![0].text {
                if categoryName.isEmpty {
                    print("Lutfen isim girin")
                } else {
                    categoryName = categoryName.replacingOccurrences(of: " ", with: "")
                    categoryName = categoryName.capitalizedSentence
                    self.homeViewPresenterDelegate?.addCategory(categoryName: categoryName)
                }
            }
        }
        
        alert.addAction(okayButton)
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true)
    }
    
    @IBAction func addTodoBtn(_ sender: Any) {
    }
    
    func changeCategoriesCellDesign() {
        let design = UICollectionViewFlowLayout()
        
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        design.minimumLineSpacing = 15
        design.minimumInteritemSpacing = 15
        
        let screenWidth = UIScreen.main.bounds.width
        
        let itemWidth = (screenWidth - 70) / 1.8
        
        design.itemSize = CGSize(width: itemWidth, height: itemWidth / 1.7)
        
        design.scrollDirection = .horizontal
        
        categoriesCollectionView.collectionViewLayout = design
        
    }
}

extension HomeViewController : PresenterToViewHomeViewProtocol {
    func sendDataToView(todos: [Todo]) {
        self.todos = todos
        self.todosTableView.reloadData()
    }
    
    func sendDataToView(categories: [Category]) {
        self.categories = categories
        self.categoriesCollectionView.reloadData()
    }
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        
        let category = categories[indexPath.row]
        
        cell.categoryNameLabel.text = category.category_name
        
        cell.homeViewPresenterDelegate = homeViewPresenterDelegate
        
        cell.categoryID = category.category_id
        
        cell.layer.cornerRadius = 15
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        todosListTitleLabel.text = "\(category.category_name!) Todos"
        
        homeViewPresenterDelegate?.getTodos(categoryID: category.category_id!)
        self.todosTableView.reloadData()
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = todosTableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoTableViewCell
        
        let todo = todos[indexPath.row]
        
        cell.todoTitleLabel.text = todo.todo_title
        cell.todoDescLabel.text = todo.todo_description
        cell.todoCellBackground.layer.cornerRadius = 10
        
        cell.homeViewPresenterDelegate = homeViewPresenterDelegate
        cell.todo = todo
        
        return cell
    }
}

