//
//  GetAllCharactersRequest.swift
//  RickAndMortyApp
//
//  Created by Mehmet Ozkan on 30.01.2024.
//

import Foundation

typealias RickMortyResponse = RickMortyModel

struct GetAllCharactersRequest: Request {
    typealias Response = RickMortyResponse
    
    let baseUrl: String = "https://rickandmortyapi.com/api"
    let path: String = "/character"
    let method: HTTPMethod = .GET
    let param: String?
    
    init() {
        self.param = ""
    }
}
