//
//  APIController.swift
//  Water My Plants
//
//  Created by Sammy Alvarado on 10/15/20.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case noId
    case noBearerToken
    case noData
    case noDecode
    case noEncode
    case failedSignUp
    case failedSignIn
}

enum HTTPMethod: String {
    case get = "Get"
    case post = "POST"
}


class UserController {
    
    private let fireBaseURL = URL(string: "https://water-my-plant-1b44a.firebaseio.com/")!
    private let baseURL = URL(string: "https://watertheplants.herokuapp.com/api/")!
    private lazy var signUpURL = baseURL.appendingPathComponent("auth/register")
    private lazy var signInURL = baseURL.appendingPathComponent("auth/login")
    
    var bearer: Bearer?
    
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
    
    private func postRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    
    func signUp(with user: User, completion: @escaping (Result<Bool, NetworkError>) ->Void) {
        print("SignUpURL = \(signInURL.absoluteString)")
        
        var request = postRequest(for: signUpURL)
        
        
        do {
            let jsonData = try JSONEncoder().encode(user)
            print(String(data: jsonData, encoding: .utf8)!)
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { (_, response, error) in
                
                if let error = error {
                    print("Sign Up failed with error: \(error)")
                    completion(.failure(.failedSignUp))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    print("Sign up was unsuccessful")
                    completion(.failure(.failedSignUp))
                    return
                }
                completion(.success(true))
                
            }
            task.resume()
        } catch {
            print("Error encoding user: \(error)")
            completion(.failure(.failedSignUp))
        }
        
    }
    
    func signIn(with user: User, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        var request = postRequest(for: signInURL)
        
        do {
            let jsonData = try JSONEncoder().encode(user)
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Sign in failed with error: \(error)")
                    completion(.failure(.failedSignIn))
                    return
                }
                guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    print("Sign in was unsuccessful")
                    completion(.failure(.failedSignIn))
                    return
                }
                guard let data = data else {
                    print("Data was not received")
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    self.bearer = try JSONDecoder().decode(Bearer.self, from: data)
                    completion(.success(true))
                } catch {
                    print("Error decoding berrer: \(error)")
                    completion(.failure(.noBearerToken))
                    return
                }
            }
            task.resume()
        } catch {
            print("Error encoding user: \(error.localizedDescription)")
            completion(.failure(.failedSignIn))
        }
        
    }
}


