//
//  APIClient.swift
//  RickAndMortyApp
//
//  Created by Mehmet Ozkan on 30.01.2024.
//

import Foundation

struct BaseService {
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    func send<T: Request>(_ request: T) async throws -> T.Response {
        let (data, _) = try await session.data(for: request.asURLRequest)
        return try decoder.decode(T.Response.self, from: data)
    }
}
