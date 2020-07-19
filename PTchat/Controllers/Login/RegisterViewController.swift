//
//  RegisterViewController.swift
//  PTchat
//
//  Created by Tiếp Sỹ Minh Phụng on 7/11/20.
//  Copyright © 2020 PTgroup. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    private let firstNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "First Name..."
        field.leftView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: 15,
                                              height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    private let lastNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Last Name..."
        field.leftView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: 15,
                                              height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address..."
        field.leftView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: 15,
                                              height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password..."
        field.leftView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: 15,
                                              height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    private let passwordAgainField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password Again..."
        field.leftView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: 15,
                                              height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        view.backgroundColor = UIColor.white
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
//                                                            style: .done,
//                                                            target: self,
//                                                            action: #selector(didTapRegister))
        registerButton.addTarget(self,
                              action: #selector(registerButtonTapped),
                              for: .touchUpInside)
        
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        passwordAgainField.delegate = self
        
        //Add subview
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(passwordAgainField)
        scrollView.addSubview(registerButton)
        
        scrollView.isUserInteractionEnabled = true
        imageView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(didTapChangeProfilePic))
//        gesture.numberOfTouchesRequired = 1
//        gesture.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapChangeProfilePic(){
        presentPhotoActionSheet()
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        let size = view.width/3
        imageView.frame = CGRect(x:(scrollView.width-size)/2,
                                 y: 40,
                                 width: size,
                                 height: size)
        imageView.layer.cornerRadius = imageView.width/2.0
        firstNameField.frame = CGRect(x:30,
                                  y: imageView.bottom+10,
                                  width: scrollView.width-60,
                                  height: 52)
        lastNameField.frame = CGRect(x: 30,
                                     y: firstNameField.bottom+10,
                                     width: scrollView.width-60,
                                     height: 52)
        emailField.frame = CGRect(x: 30,
                                   y: lastNameField.bottom+10,
                                   width: scrollView.width-60,
                                   height: 52)
        passwordField.frame = CGRect(x: 30,
                                  y: emailField.bottom+10,
                                  width: scrollView.width-60,
                                  height: 52)
        passwordAgainField.frame = CGRect(x: 30,
                                  y: passwordField.bottom+10,
                                  width: scrollView.width-60,
                                  height: 52)
        registerButton.frame =  CGRect(x: 30,
                                    y: passwordAgainField.bottom+10,
                                    width: scrollView.width-60,
                                    height: 52)
        
    }
    @objc private func registerButtonTapped(){
        
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        passwordAgainField.resignFirstResponder()
        
        
        guard let firstname = firstNameField.text,
              let lastname = lastNameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              let passwordAgain = passwordAgainField.text,
                !firstname.isEmpty,
                !lastname.isEmpty,
                !email.isEmpty,
                !password.isEmpty,
                !passwordAgain.isEmpty,
                password.count >= 8 else{
                    alertUserLoginError()
                    return
            }
        //Firebase Register
        
        DatabaseManager.shared.userExists(with: email, completion: { [weak self] exist in
            guard let strongSelf = self else{
                return
            }
            
            guard !exist else {
                //user already exists
                strongSelf.alertUserLoginError(message: "Email address already exists")
                return
            }
            FirebaseAuth.Auth.auth().createUser(withEmail: email,password: password,completion: {authResult,error in
                    guard authResult != nil,  error == nil else{
                        print("Error creating user...")
                        return
                    }
                    DatabaseManager.shared.insertUsers(with: ChatAppUser(firstName: firstname,
                                                                         lastName: lastname,
                                                                         emailAddress: email))
                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
                
                })
            })
            
        }
        
        
        
        
    func alertUserLoginError(message : String = "Please enter all infomation to create a new account."){
            let alert = UIAlertController(title: "Woops",
                                          message: message,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dissmiss",
                                          style: .cancel,
                                          handler: nil))
            present(alert,animated: true)
        }
        
        @objc private func didTapRegister(){
            let vc = RegisterViewController()
            vc.title = "Create Account"
            navigationController?.pushViewController(vc, animated: true)
        }
    }

extension RegisterViewController: UITextFieldDelegate{
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
            if textField == firstNameField{
                lastNameField.becomeFirstResponder()
            }else if textField == lastNameField{
                emailField.becomeFirstResponder()
            }else if textField == emailField{
                passwordField.becomeFirstResponder()
            }else if textField == passwordField{
                passwordAgainField.becomeFirstResponder()
            }else if textField == passwordAgainField{
                registerButtonTapped()
            }
            
            return true
        }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "How would you like to select a picture?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: { [weak self]_ in
                                                self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Chose Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
                                                self?.presentPhotoPicker()
        }))
        present(actionSheet, animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        self.imageView.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
