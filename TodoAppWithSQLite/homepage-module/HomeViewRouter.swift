//
//  HomeViewRouter.swift
//  TodoAppWithSQLite
//
//  Created by Yılmaz Yağız Dokumacı on 2.02.2023.
//

import Foundation

class HomeViewRouter : PresenterToRouterProtocol {
    
    static func createModule(ref: HomeViewController) {
        
        let presenter = HomeViewPresenter()
        
        // View
        ref.homeViewPresenterDelegate = presenter
        
        // Presenter
        ref.homeViewPresenterDelegate?.view = ref
        ref.homeViewPresenterDelegate?.interactor = HomeViewInteractor()
        
        // Interactor
        ref.homeViewPresenterDelegate?.interactor?.presenter = presenter
    }
}
