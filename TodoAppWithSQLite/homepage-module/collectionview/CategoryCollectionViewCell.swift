//
//  CategoryCollectionViewCell.swift
//  TodoAppWithSQLite
//
//  Created by Yılmaz Yağız Dokumacı on 1.02.2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellBackground: UIView!
    
    @IBOutlet weak var taskCountLabel: UILabel!
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    
    @IBOutlet weak var categoryProgressView: UIProgressView!
}
