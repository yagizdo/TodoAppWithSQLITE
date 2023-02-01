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
    
    // Database object
    var db:FMDatabase?
    
    // When the application runs for the first time, we make it copy our sqlite file into the phone.
    func copyDatabase() {
        let bundlePath = Bundle.main.path(forResource: "todoapp", ofType: ".db")
        let destinationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let copyPath = URL(fileURLWithPath: destinationPath).appendingPathComponent("todoapp.db")
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
        copyDatabase()
        dbInit()
        
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        
        todosTableView.delegate = self
        todosTableView.dataSource = self
        todosTableView.separatorStyle = .none
        changeCellDesign()
    }
    
    func changeCellDesign() {
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
    
    func dbInit() {
        // We want to access the database as soon as it runs
        // Public path where this database is
          let destinationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
          
        // Now we represent the original copy location and give the file a name it will copy with the name we gave
          let databaseURL = URL(fileURLWithPath: destinationPath).appendingPathComponent("todoapp.db")
          
        // we provide access to the database
          db = FMDatabase(path: databaseURL.path)
    }
}


extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
 
        cell.categoryNameLabel.text = "Deneme"
        
        cell.layer.cornerRadius = 15
        
        return cell
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = todosTableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoTableViewCell
        
        cell.todoTitleLabel.text = "Todo \(indexPath.row)"
        cell.todoDescLabel.text = "Todo desc \(indexPath.row)"
        cell.todoCellBackground.layer.cornerRadius = 10
        
        return cell
    }
}


