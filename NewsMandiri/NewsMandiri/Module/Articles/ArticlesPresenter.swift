//
//  ArticlesPresenter.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//  
//

import Foundation

class ArticlesPresenter: ViewToPresenterArticlesProtocol {

    // MARK: Properties
    weak var view: PresenterToViewArticlesProtocol?
    var interactor: PresenterToInteractorArticlesProtocol?
    var router: PresenterToRouterArticlesProtocol?
    var articles: [Article] = []
    
    func viewDidLoad() {
        interactor?.loadArticle()
    }
    
    func loadNextPage() {
        interactor?.loadNextPage()
    }
    
    func refresh() {
        interactor?.refreshArticle()
    }
    
    func didSelectRowAt(article: Article) {
        interactor?.retrieveArticle(article: article)
    }
}

extension ArticlesPresenter: InteractorToPresenterArticlesProtocol {
    func fetchArticleSuccess(articles: [Article], isFirstPage: Bool) {
        self.articles = articles
        view?.onFetchArticleSuccess(articles: articles, isFirstPage: isFirstPage)
    }
    
    func fetchArticleFailure(isFirstPage: Bool) {
        view?.onFetchArticleFailure(isFirstPage: isFirstPage)
    }
    
    func findArticleSuccess(_ article: Article) {
        router?.navigateToDetailArticle(on: view!, with: article)
    }
}
