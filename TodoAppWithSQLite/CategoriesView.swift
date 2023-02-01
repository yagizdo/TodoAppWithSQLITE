//
//  ViewController.swift
//  TodoAppWithSQLite
//
//  Created by Yılmaz Yağız Dokumacı on 1.02.2023.
//

import UIKit

class CategoriesView: UIViewController {
    
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

