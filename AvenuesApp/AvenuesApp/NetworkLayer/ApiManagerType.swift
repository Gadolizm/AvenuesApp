//
//  ApiManagerType.swift
//  AvenuesApp
//
//  Created by Haitham Gado on 13/02/2024.
//

import Foundation
import Combine

protocol ApiManagerType {
    func fetch<T: Decodable>(url: URL) -> AnyPublisher <T, ApiError>
}
