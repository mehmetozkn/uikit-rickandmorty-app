//
//  RickMortyViewModel.swift
//  RickAndMortyApp
//
//  Created by Mehmet Ozkan on 30.01.2024.
//

import Foundation

protocol IRickMortyViewModel {
    func fetchAllCharacters() async -> Void
    func changeLoading()
    
    var rickMortyCharacters: [Result] { get set }
    var service: BaseService { get }
    
    var rickMortyOutput: RickMortyOutput? { get }
    
    func setDelegate(output: RickMortyOutput)

}

final class RickMortyViewModel : IRickMortyViewModel {
    var rickMortyOutput: RickMortyOutput?
    
    func setDelegate(output: RickMortyOutput) {
        rickMortyOutput = output
    }
    
    var rickMortyCharacters: [Result] = []
    let service: BaseService
    private var isLoading = false
    
    init() {
        service = BaseService()
    }
    
    func fetchAllCharacters() async {
        let request = GetAllCharactersRequest()
        changeLoading()
        do {
            rickMortyCharacters = try await service.send(request).results ?? []
            await rickMortyOutput?.saveDatas(values: self.rickMortyCharacters)
            changeLoading()
        } catch {
            
        }
      
    }
    
    func changeLoading() {
        isLoading = !isLoading
        rickMortyOutput?.changeLoading(isLoad: isLoading)
    }
    
}
