//
//  APIClient.swift
//  iOS-Workout-app
//
//  Created by Yael Bilu Eran on 29/11/2020.
//

import Foundation
public enum APIError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Request Failed"
        case .invalidEndpoint: return "Invalid Data"
        case .invalidResponse: return "Response Unsuccessful"
        case .noData: return "JSON Parsing Failure"
        case .serializationError: return "JSON Conversion Failure"
        }
    }
}
enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}

protocol APIClient {
    var session: URLSession { get }
    
    func fetch<T: Decodable>(with url: URLRequest?, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
}

extension APIClient {
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    private func decodingTask<T: Decodable>(with url: URLRequest?, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask? {
        guard let apiUrl  = url else {
           completion(nil, .invalidResponse)
           return nil
        }
            
        let task = session.dataTask(with: apiUrl) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else{
                completion(nil, .invalidResponse)
                return
            }
            if let data = data {
                do {
                    let genericModel = try JSONDecoder().decode(decodingType, from: data)
                    completion(genericModel, nil)
                } catch {
                    print(error)
                    completion(nil, .serializationError)
                }
            } else {
                completion(nil, .noData)
            }
        }
        return task
    }
    
    func fetch<T: Decodable>(with url: URLRequest?, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        let task = decodingTask(with: url, decodingType: T.self) { (json , error) in
            
            //MARK: change to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.noData))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.serializationError))
                }
            }
        }
        task?.resume()
    }
}
