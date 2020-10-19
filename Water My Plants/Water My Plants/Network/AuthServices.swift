//
//  AuthServices.swift
//  Water My Plants
//
//  Created by Sammy Alvarado on 10/17/20.
//

import Foundation
import Firebase

class AuthServices {
    func signUp(withUsername username: String, email: String, password: String, image: UIImage?, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (AuthDataResult, error) in
            if error != nil {
                print(error)
                return
            }
            if let authData = AuthDataResult {
                print(authData.user.email)
                var dict: Dictionary<String, Any> = [
                    "uid": authData.user.uid,
                    "username": username,
                    "email": authData.user.email,
                    "profileImageUrl": "",
                ]
                guard let imageSelected = image else {
                    print("User image is nil")
                    return
                }
                guard let imageData = imageSelected.jpegData(compressionQuality: 0.9) else {
                    return
                }
                let storageRef = Storage.storage().reference(forURL: "gs://water-my-plant-1b44a.appspot.com")
                let storageProfileRef = storageRef.child("userProfile").child(authData.user.uid)
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpg"
                storageProfileRef.putData(imageData, metadata: metadata, completion: { (storageMetaData, error) in
                    if error != nil {
                        print(error?.localizedDescription)
                        return
                    }
                    storageProfileRef.downloadURL(completion: { (url, error) in
                        if let metaImageUrl = url?.absoluteString {
                            dict["profileImageUrl"] = metaImageUrl
                            Database.database().reference().child("users").child(authData.user.uid).updateChildValues(dict, withCompletionBlock: { (error, ref) in
                                if error == nil {
                                    print("Done")
                                    onSuccess()
                                } else {
                                    onError(error!.localizedDescription)
                                }
                            })
                        }
                    })
                })
            }
        }
    }
}
