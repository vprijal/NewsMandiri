//
//  CategoriesPresenter.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//  
//

import Foundation

class CategoriesPresenter: ViewToPresenterCategoriesProtocol {

    // MARK: Properties
    weak var view: PresenterToViewCategoriesProtocol?
    var interactor: PresenterToInteractorCategoriesProtocol?
    var router: PresenterToRouterCategoriesProtocol?
}

extension CategoriesPresenter: InteractorToPresenterCategoriesProtocol {
    
}
