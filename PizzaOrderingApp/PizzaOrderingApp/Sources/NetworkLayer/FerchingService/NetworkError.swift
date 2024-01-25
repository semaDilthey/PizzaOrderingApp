//
//  NetworkError.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 18.01.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL, invalidResponse, noData, jsonParsingFailed
}
