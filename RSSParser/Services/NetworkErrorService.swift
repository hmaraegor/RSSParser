//
//  NetworkErrorService.swift
//  RSSParser
//
//  Created by Egor on 08/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import Foundation

enum NetworkErrorService: Error {
    case badURL
    case noResponse
    case noData
    case xmlDecoding
    case networkError
    case badResponse
}
