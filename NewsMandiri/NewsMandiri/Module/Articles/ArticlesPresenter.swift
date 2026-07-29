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
    
    func didSelectRowAt(article: Article) {
        interactor?.retrieveArticle(article: article)
    }
}

extension ArticlesPresenter: InteractorToPresenterArticlesProtocol {
    func fetchArticleSuccess(article: [Article]) {
        self.articles = article
        view?.onFetchArticleSuccess(article: article)
    }
    
    func fetchArticleFailure() {
        view?.onFetchArticleFailure()
    }
    
    func findArticleSuccess(_ article: Article) {
        router?.navigateToDetailArticle(on: view!, with: article)
    }
}
