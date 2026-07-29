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
    var category: [String] = []
    
    func viewDidLoad() {
        interactor?.loadCategory()
    }
    
    func didSelectRowAt(index: Int) {
        interactor?.retrieveCategory(at: index)
    }
}

extension CategoriesPresenter: InteractorToPresenterCategoriesProtocol {
    func getDataCategorySuccess(category: [Category]) {
        self.category = category.compactMap({$0.name})
        view?.onGetCategorySuccess(category: self.category)
    }
    
    func findCategorySuccess(_ category: String) {
        router?.navigateToSource(on: view!, with: category)
    }
    
    
}
