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
    case otherError
    case failedSignUp
    case failedSignIn
    case tryAgain
}

enum HTTPMethod: String {
    case get = "Get"
    case post = "POST"
}


class UserController {
    
    private let fireBaseURL = URL(string: "https://water-my-plant-1b44a.firebaseio.com/")!
    private let baseURL = URL(string: "https://watertheplants.herokuapp.com/api")!
    private lazy var signUpURL = baseURL.appendingPathComponent("/auth/register")
    private lazy var signInURL = baseURL.appendingPathComponent("/auth/login")
    private lazy var usersDetialURl = baseURL.appendingPathComponent("/users")
    
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
    
    
    func fetchUsersDetails(for userName: String, completion:@escaping (Result<User, NetworkError>) ->Void) {
        guard let bearer = bearer else {
            completion(.failure(.noBearerToken))
            return
        }
        
        var request = URLRequest(url: usersDetialURl.appendingPathComponent(userName))
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")
        
        let fetchUsersDetailsTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error receiving animal detial data: \(error)")
                completion(.failure(.tryAgain))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.noBearerToken))
                return
            }
            
            guard let data = data else {
                print("No data received from fetchUsersDetails from animal: \(userName)")
                completion(.failure(.noData))
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .secondsSince1970
                let userDetail = try jsonDecoder.decode(User.self, from: data)
                completion(.success(userDetail))
            } catch {
                print("Error decoding user detail data (user name = \(userName)): \(error)")
                completion(.failure(.tryAgain))
            }
            
        }
        fetchUsersDetailsTask.resume()
    }
}


