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
    
    private(set) var isFetching: Bool = false
    private(set) var hasMorePages: Bool = true
    private var currentPage: Int = 1
    private let pageSize: Int = 20
    private var articles: [Article] = []
    private var totalResults: Int = 0

    func loadArticle() {
        guard !isFetching else { return }
        isFetching = true
        let isFirstPage = (currentPage == 1)
        
        Task {
            do {
                let response: ArticleResponse = try await network.request(
                    route: .article(id: sourceID ?? "", page: currentPage, pageSize: pageSize)
                )
                self.totalResults = response.totalResults
                let newArticles = response.articles
                
                if isFirstPage {
                    self.articles = newArticles
                } else {
                    self.articles.append(contentsOf: newArticles)
                }
                
                self.currentPage += 1
                if self.articles.count >= self.totalResults || newArticles.isEmpty {
                    self.hasMorePages = false
                }
                
                self.isFetching = false
                self.presenter?.fetchArticleSuccess(articles: self.articles, isFirstPage: isFirstPage)
            } catch {
                self.isFetching = false
                self.presenter?.fetchArticleFailure(isFirstPage: isFirstPage)
            }
        }
    }
    
    func loadNextPage() {
        guard !isFetching && hasMorePages else { return }
        loadArticle()
    }
    
    func refreshArticle() {
        currentPage = 1
        hasMorePages = true
        articles = []
        totalResults = 0
        loadArticle()
    }
    
    func retrieveArticle(article: Article) {
        self.presenter?.findArticleSuccess(article)
    }
}
