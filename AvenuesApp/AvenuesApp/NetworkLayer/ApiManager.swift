//
//  ApiManager.swift
//  AvenuesApp
//
//  Created by Haitham Gado on 13/02/2024.
//

import Foundation
import Combine

class ApiManager: ApiManagerType {
    
    private var session: URLSession
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetch<T: Decodable>(url: URL) -> AnyPublisher <T, ApiError> {
        self.session.dataTaskPublisher(for: url)
            .tryMap({ result in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw ApiError.requestFailed
                }
                if (200..<300) ~= httpResponse.statusCode {
                    return result.data
                }
                throw ApiError.invalidResponse
            })
            .receive(on: RunLoop.main)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError({ error -> ApiError in
                if let error = error as? ApiError {
                    return error
                }
                return ApiError.decodingFailed
            })
            .eraseToAnyPublisher()
    }
}

enum ApiError: Error {
    case badURL
    case requestFailed
    case invalidResponse
    case decodingFailed
    case customError(ErrorModel)
    var errorDescription: String? {
        switch self {
        case .requestFailed:
            return "Server is not reachable"
        case .badURL:
            return "Not a valid URL"
        case .decodingFailed:
            return "Json failed"
        case .invalidResponse:
            return "Response type not a json"
        case .customError(let model):
            return model.message
        }
    }
}

struct ErrorModel: Codable {
    let code: String?
    let message: String?
}
