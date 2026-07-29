//
//  ArticlesInteractor.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//  
//

import Foundation

class ArticlesInteractor: PresenterToInteractorArticlesProtocol {

    // MARK: Properties
    weak var presenter: InteractorToPresenterArticlesProtocol?
    var sourceID: String?
    var network: NetworkManager = NetworkManager.shared
    var article: [Article]?
    
    func loadArticle() {
        Task {
            do {
                let response: ArticleResponse = try await network.request(route: .article(id: sourceID ?? ""))
                self.article = response.articles
                self.presenter?.fetchArticleSuccess(article: response.articles)
            } catch {
                self.presenter?.fetchArticleFailure()
            }
        }
    }
    
    func retrieveArticle(article: Article) {
        self.presenter?.findArticleSuccess(article)
    }
}
