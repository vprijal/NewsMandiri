//
//  ArticleResponse.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//

struct ArticleResponse: Codable, Hashable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable, Hashable {
    let source: SourceArticle
    let author: String?
    let title: String
    let articleDescription: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
    
}

struct SourceArticle: Codable, Hashable {
    let id: String?
    let name: String
}
