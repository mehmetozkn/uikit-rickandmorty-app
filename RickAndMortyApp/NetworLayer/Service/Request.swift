//
//  Request.swift
//  RickAndMortyApp
//
//  Created by Mehmet Ozkan on 30.01.2024.
//

import Foundation

protocol Request {
    associatedtype Response: Decodable
    
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var param: String? { get }
    
}

extension Request {
    var asURLRequest: URLRequest {
        let url = URL(string: baseUrl + path + (param ?? ""))!
        let request = URLRequest(url: url)
        return request
    }
}
