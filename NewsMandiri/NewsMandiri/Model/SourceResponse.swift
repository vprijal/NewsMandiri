//
//  SourceResponse.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//

import Foundation

// MARK: - SourceResponse
struct SourceResponse: Codable, Hashable, Sendable {
    let status: String
    let sources: [Source]
}

// MARK: - Source
nonisolated struct Source: Codable, Hashable, Sendable {
    let id, name, sourceDescription: String
    let url: String
    let category, language, country: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case sourceDescription = "description"
        case url, category, language, country
    }
}
