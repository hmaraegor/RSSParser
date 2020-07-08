//
//  ErrorAlertService.swift
//  RSSParser
//
//  Created by Egor on 08/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class ErrorAlertService {
    
    private init() { }
    
    static func showErrorAlert(error: NetworkErrorService, viewController: UIViewController) {
        var errorMessage = String()
        switch error{
        case .badURL:
            errorMessage = "URL has incorrect format"
        case .noResponse:
            errorMessage = "Response was not received"
        case .noData:
            errorMessage = "Data was not received"
        case .xmlDecoding:
            errorMessage = "Data decoding error"
        case .networkError:
            errorMessage = "Network error"
        case .badResponse:
            errorMessage = "Response returned an error"
        @unknown default:
            errorMessage = "Network Service error"
        }
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
