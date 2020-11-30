//
//  DataProvider.swift
//  iOS-Workout-app
//
//  Created by Yael Bilu Eran on 29/11/2020.
//

import Foundation
public class DataProvider :APIClient {
    let session: URLSession
    public static let shared = DataProvider()
    private let baseUrl = "https://ios-interviews.dev.fitvdev.com"
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func fetchWorkoutDetails(completion: @escaping (Result<WorkoutDetails?, APIError>) -> Void) {
        let urlApiPath = "\(baseUrl)/getWorkoutDetails"
        guard let url = URL(string: urlApiPath) else {
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        fetch(with: request , decode: { json -> WorkoutDetails? in
            guard let result = json as? WorkoutDetails else { return  nil }
            return result
        }, completion: {result  in
            switch result{
            case .success(let dataResponse):
                completion(Result.success(dataResponse))
            case .failure(let error):
                completion(Result.failure(error))
            }
        })
    }
    
    func addWorkoutSummary(summary: WorkoutSummary, completion: @escaping (Result<Int?, APIError>) -> Void) {
        let urlApiPath = "\(baseUrl)/addWorkoutSummary"
        guard let url = URL(string: urlApiPath) else {
            return
        }
        
        do {
            let encoder = JSONEncoder()
            // Encode WorkoutSummary
            let summaryData = try encoder.encode(summary)
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = summaryData
          
            fetch(with: request , decode: { json -> WorkoutSummaryResponse? in
                guard let result = json as? WorkoutSummaryResponse else { return  nil }
                return result
            }, completion: {result  in
                switch result{
                case .success(let dataResponse):
                    completion(Result.success(dataResponse.totalTimeCompleted))
                case .failure(let error):
                    completion(Result.failure(error))
                }
            })
        } catch {
            completion(Result.failure(APIError.invalidResponse))
        }
    }
}

    
    
    
    
    
   
    

