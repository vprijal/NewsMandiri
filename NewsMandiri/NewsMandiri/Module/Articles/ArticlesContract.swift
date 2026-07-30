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
    func onFetchArticleSuccess(articles: [Article], isFirstPage: Bool)
    func onFetchArticleFailure(isFirstPage: Bool)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterArticlesProtocol: AnyObject {
    
    var view: PresenterToViewArticlesProtocol? { get set }
    var interactor: PresenterToInteractorArticlesProtocol? { get set }
    var router: PresenterToRouterArticlesProtocol? { get set }
    var articles: [Article] { get set }
    func viewDidLoad()
    func loadNextPage()
    func refresh()
    func didSelectRowAt(article: Article)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorArticlesProtocol {
    
    var presenter: InteractorToPresenterArticlesProtocol? { get set }
    var sourceID: String? { get set }
    var isFetching: Bool { get }
    var hasMorePages: Bool { get }
    func loadArticle()
    func loadNextPage()
    func refreshArticle()
    func retrieveArticle(article: Article)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterArticlesProtocol: AnyObject {
    func fetchArticleSuccess(articles: [Article], isFirstPage: Bool)
    func fetchArticleFailure(isFirstPage: Bool)
    func findArticleSuccess(_ article: Article)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterArticlesProtocol {
    func navigateToDetailArticle(on view: PresenterToViewArticlesProtocol, with article: Article)
}
