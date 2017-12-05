//
//  LoginController+Handlers.swift
//  mexicoConsciente
//
//  Created by Daniel Ramirez on 7/5/17.
//  Copyright © 2017 simpleCoding. All rights reserved.
//
import UIKit
import Foundation
import Firebase

extension LogVC: UINavigationControllerDelegate{
    
    
    //manejar el registro
    @objc func handleRegister(){
        //primero llamamos mandar las variables dentro de guards
        guard let email = emailTextfield.text,let name = nameTextfield.text, let password = passwordTextfield.text else{
            print("form is not valid")
            return
        }
        
        //llamada para autentificar firebase
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print("error \(error!)")
                return
            }
            
            guard let uid = user?.uid else{
                return
            }
            
            //succesfully authenticated user
            let imageName = NSUUID().uuidString
            //call storage reference
            let storageRef = Storage.storage().reference().child("userProfileImage").child("\(imageName).jpg" )
            
            
            //scalamos la imagen a 0.1  = 10% de la imagen STORAGE
            if let profileImage = self.profileImageView.image ,let uploadData = UIImageJPEGRepresentation(profileImage, 0.1){
                
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    
                    if error != nil{
                        print(error)
                        return
                    }
                    //succes uploading the data , we change the value of DATABASE
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString{
                        let premium = false
                        let values = ["name": name, "email": email, "profileImageUrl": profileImageUrl,"hasPremium": premium] as [String : Any]
                        //registramos la informacion
                        self.registerUserInfoDatabaseWithUid(uid: uid, values: values)
                    }
                    
                })
            }
        })
    }
    
    
    private func registerUserInfoDatabaseWithUid(uid:String,values:[String:Any]){
        let ref = Database.database().reference()
        //creamos la referencia a usuarios .child uid
        let userReference = ref.child("user").child(uid)
        
        
        userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil{
                print(error!)
                return
            }
            //user succesfully into firebase DB
            print("user succesfully into firebase DB")
            self.dismiss(animated: true, completion: nil)
            
        })
    }
}




