//
//  ArticlesContract.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewArticlesProtocol: AnyObject {
    func onFetchArticleSuccess(article: [Article])
    func onFetchArticleFailure()
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterArticlesProtocol: AnyObject {
    
    var view: PresenterToViewArticlesProtocol? { get set }
    var interactor: PresenterToInteractorArticlesProtocol? { get set }
    var router: PresenterToRouterArticlesProtocol? { get set }
    var articles: [Article] { get set}
    func viewDidLoad()
    func didSelectRowAt(article: Article)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorArticlesProtocol {
    
    var presenter: InteractorToPresenterArticlesProtocol? { get set }
    var sourceID: String? {get set}
    func loadArticle()
    func retrieveArticle(article: Article)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterArticlesProtocol: AnyObject {
    func fetchArticleSuccess(article: [Article])
    func fetchArticleFailure()
    func findArticleSuccess(_ article: Article)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterArticlesProtocol {
    func navigateToDetailArticle(on view: PresenterToViewArticlesProtocol, with article: Article)
}
