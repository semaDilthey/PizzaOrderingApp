//
//  NetworkManager.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 18.01.2024.
//

import Foundation

protocol Networking : AnyObject {
    func getMenu(completion: @escaping (Result<[Menu], Error>) -> Void)
}

final class NetworkManager : Networking {
    
    var fetchingService: FetchingServiceProtocol
        
    init(fetchingService: FetchingServiceProtocol = FetchingService()) {
        self.fetchingService = fetchingService
    }
    
    func getMenu(completion: @escaping (Result<[Menu], Error>) -> Void) {
        fetchingService.getData(from: API.menu, completion: completion)
    }
    
    
}

