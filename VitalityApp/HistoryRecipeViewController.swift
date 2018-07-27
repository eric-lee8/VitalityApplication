//
//  HistoryRecipeViewController.swift
//  VitalityApp
//
//  Created by Jacky Huynh on 2018-07-23.
//  Copyright © 2018 Eric Joseph Lee. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

class HistoryRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var recipeImageView: UIImageView!
    @IBOutlet var btnURLlabel: UIButton!
    @IBOutlet var ingredients_list: UITextView!
    @IBOutlet var btnUpload: UIButton!
    
    var recipe:String = ""
    var ingredients = [String]()
    var recipe_URL:String = ""
    var cuisine:String = ""
    var imageURL:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var databaseHandle:DatabaseHandle
        
        // sets the button title
        btnURLlabel.setTitle(recipe, for: .normal)
        var str_ingredients = String()
        
        for ingredient in ingredients {
            str_ingredients += ingredient + "\n"
        }
        
        //Display the list of ingredients
        ingredients_list.text = str_ingredients
        
        databaseHandle = Database.database().reference().child((UserDefaults.standard.object(forKey: "username") as? String)!).observe(.childAdded, with: { (snapshot) in
            let database_recipe = snapshot.value as? [String]
            let data = database_recipe
            
            if (data!.count == 3 && data![0] == self.recipe) {
                self.btnUpload.setTitle("LOADING", for: .normal)
                self.imageURL = data![2]
                
                let url = URL(string: self.imageURL)
                URLSession.shared.dataTask(with: url!) { (data, response, error) in
                    if (error != nil) {
                        print(error)
                        return
                    }
                    DispatchQueue.main.async {
                        self.recipeImageView?.image = UIImage(data: data!)
                        self.btnUpload.setTitle("", for: .normal)
                    }

                }.resume()
                
            }
            
        })
        
        
    }
    
    @IBAction func recipeImageBtn(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imageName = NSUUID().uuidString
        var selectedImageFromPicker: UIImage?
        let storageRef = Storage.storage().reference().child("\(imageName).png")
        let rootRef = Database.database().reference()

        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
        }
        else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker {
            recipeImageView.image = selectedImage
            btnUpload.setTitle("", for: .normal)
        }
        if let uploadData = UIImagePNGRepresentation(recipeImageView.image!) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if (error != nil) {
                    print("error uploading")
                    return
                }
                print("uploaded")
                
                storageRef.downloadURL(completion: { (url, error) in
                    rootRef.child((UserDefaults.standard.object(forKey: "username") as? String)!).child(self.recipe).setValue([self.recipe, self.cuisine,  url!.absoluteString])
                })
                
            }
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnURL(_ sender: Any) {
        UIApplication.shared.open(URL(string: recipe_URL)!)
    }
    
    @IBAction func btnHome(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}

