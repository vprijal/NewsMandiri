//
//  CategoriesRouter.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//  
//

import Foundation
import UIKit

class CategoriesRouter: PresenterToRouterCategoriesProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = CategoriesViewController()
        
        let presenter: ViewToPresenterCategoriesProtocol & InteractorToPresenterCategoriesProtocol = CategoriesPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = CategoriesRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = CategoriesInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    
    func navigateToSource(on view: any PresenterToViewCategoriesProtocol, with category: String) {
        let sourceVC = SourcesRouter.createModule(category: category)
        sourceVC.navigationItem.title = category
        let viewController = view as! CategoriesViewController
        viewController.navigationController?
            .pushViewController(sourceVC, animated: true)
    }
}
