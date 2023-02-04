//
//  TodoDetailRouter.swift
//  TodoAppWithSQLite
//
//  Created by Yılmaz Yağız Dokumacı on 4.02.2023.
//

import Foundation

class TodoDetailRouter : PresenterToRouterTodoDetailProtocol {
    static func createModule(ref: TodoDetailViewController) {
        
        // View
        ref.todoDetailPresentDelegate = TodoDetailPresenter()
        // Presenter
        ref.todoDetailPresentDelegate?.todoDetailInteractor = TodoDetailInteractor()
        // Interactor
    }
}
