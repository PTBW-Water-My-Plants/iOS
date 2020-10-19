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
    case otherError
    case noData
    case noDecode
    case noEncode
    case noRepresentations
    case failedSignUp
}


let baseURL = URL(string: "https://water-my-plant-1b44a.firebaseio.com/")!

class PlantController {
    
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
    /*

     private func postRequest(for url: URL) -> URLRequest {
         var request = URLRequest(url: url)
         request.httpMethod = HTTPMethod.post.rawValue
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         return request
     }

     func deleteTaskFromServer(_ task: Task, completion: @escaping CompletionHandler = { _ in }) {
         guard let uuid = task.identifier else {
             completion(.failure(.noIdentifier))
             return
         }

         let requestURL = baseURL.appendingPathComponent(uuid.uuidString).appendingPathExtension("json")
         var request = URLRequest(url: requestURL)
         request.httpMethod = "DELETE"

         let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
             print(response!)
             completion(.success(true))
         }

         task.resume()

     }
     */
//    func signUp(with user: User, completion: @escaping CompletionHandler = { _ in }) {
//
//        let requestURL = baseURL.appendingPathExtension("json")
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = "Post"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//
//        let user = URLSession.shared.dataTask(with: requestURL) { (_, response, error) in
//            if let error = error {
//                print("Error failed to Sign Up with error: \(error) ")
//                completion(.failure(.failedSignUp))
//                return
//            }
//
//            do {
//                let jsonData = try JSONEncoder().encode(user)
//                print(String(data: jsonData, encoding: .utf8)!)
//                request.httpBody = jsonData
//
//
//                guard let respone = response as? HTTPURLResponse,
//                      response.statusCode == 200 else {
//                    print("Sign Up failed with error: \(error)")
//                    completion(.failure(.failedSignUp))
//                    return
//                }
//                user.resume()
//
//            } catch {
//                print("Error encoding user: \(error)")
//                completion(.failure(.failedSignUp))
//            }
//        }
//    }
    
    
}
