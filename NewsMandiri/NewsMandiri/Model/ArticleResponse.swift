//
//  ArticleResponse.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//

struct ArticleResponse: Codable, Hashable, Sendable {
    let status: String?
    let totalResults: Int
    let articles: [Article]
}

nonisolated struct Article: Codable, Hashable, Sendable {
    let source: SourceArticle?
    let author: String?
    let title: String?
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

struct SourceArticle: Codable, Hashable, Sendable {
    let id: String?
    let name: String?
}
