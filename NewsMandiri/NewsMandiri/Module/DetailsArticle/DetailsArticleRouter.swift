//
//  DetailsArticleRouter.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//  
//

import Foundation
import UIKit

class DetailsArticleRouter: PresenterToRouterDetailsArticleProtocol {
    
    // MARK: Static methods
    static func createModule(article: Article) -> UIViewController {
        
        let viewController = DetailsArticleViewController()
        
        let presenter: ViewToPresenterDetailsArticleProtocol & InteractorToPresenterDetailsArticleProtocol = DetailsArticlePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = DetailsArticleRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = DetailsArticleInteractor()
        viewController.presenter?.interactor?.article = article
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
