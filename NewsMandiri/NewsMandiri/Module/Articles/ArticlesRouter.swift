//
//  ArticlesRouter.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//  
//

import Foundation
import UIKit

class ArticlesRouter: PresenterToRouterArticlesProtocol {
    
    // MARK: Static methods
    static func createModule(sourceId: String) -> UIViewController {
        
        let viewController = ArticlesViewController()
        
        let presenter: ViewToPresenterArticlesProtocol & InteractorToPresenterArticlesProtocol = ArticlesPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = ArticlesRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = ArticlesInteractor()
        viewController.presenter?.interactor?.sourceID = sourceId
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func navigateToDetailArticle(on view: PresenterToViewArticlesProtocol, with article: Article) {
        let detailArticleVC = DetailsArticleRouter.createModule(article: article)
        detailArticleVC.navigationItem.title = article.title
        let viewController = view as! ArticlesViewController
        viewController.navigationController?
            .pushViewController(detailArticleVC, animated: true)
    }
    
}
