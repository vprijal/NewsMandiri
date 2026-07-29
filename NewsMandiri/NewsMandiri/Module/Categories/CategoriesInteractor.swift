//
//  CategoriesInteractor.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//  
//

import Foundation

class CategoriesInteractor: PresenterToInteractorCategoriesProtocol {

    // MARK: Properties
    weak var presenter: InteractorToPresenterCategoriesProtocol?
    var category: [String]?
    
    func loadCategory() {
        let data = CategoryResponse.DataCategory()
        let categoryName = data.category.compactMap({$0.name})
        self.category = categoryName
        self.presenter?.getDataCategorySuccess(category: data.category)
    }
    
    func retrieveCategory(at index: Int) {
        guard let category = self.category, category.indices.contains(index) else {
            return
        }
        self.presenter?.findCategorySuccess(self.category![index])
    }
}
