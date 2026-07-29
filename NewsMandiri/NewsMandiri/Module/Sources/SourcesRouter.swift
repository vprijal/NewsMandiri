//
//  SourcesRouter.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//  
//

import Foundation
import UIKit

class SourcesRouter: PresenterToRouterSourcesProtocol {
    
    // MARK: Static methods
    static func createModule(category: String) -> UIViewController {
        
        let viewController = SourcesViewController()
        
        let presenter: ViewToPresenterSourcesProtocol & InteractorToPresenterSourcesProtocol = SourcesPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = SourcesRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = SourcesInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func navigateToArticle(on view: PresenterToViewSourcesProtocol, with sourceId: String) {
       
    }
    
}
