//
//  HistoryRecipeViewController.swift
//  VitalityApp
//
// CMPT276
// Project Group 16
// Team Vitality
// Members: Eric Joseph Lee, Philip Choi, Jacky Huynh, Jordan Cheung
//
//  Created by Jacky Huynh on 2018-07-23.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

class HistoryRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // objects in the viewController
    @IBOutlet var recipeImageView: UIImageView!
    @IBOutlet var btnURLlabel: UIButton!
    @IBOutlet var ingredients_list: UITextView!
    @IBOutlet var btnUpload: UIButton!
    
    // grabbing the appropriate variables needed from the shared file
    var recipe:String = Shared.shared.recipe_chosen
    var ingredients = Shared.shared.recipe_ingredients
    var recipe_URL:String = Shared.shared.recipe_URL
    var cuisine:String = Shared.shared.selected_cuisine
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
        
        // goes to the database and goes to the child according to the users username
        databaseHandle = Database.database().reference().child((UserDefaults.standard.object(forKey: "username") as? String)!).observe(.childAdded, with: { (snapshot) in
            let database_recipe = snapshot.value as? [String]
            let data = database_recipe
            
            // checks if the data contains a url and matches the recipe that users have chosen
            // if so download the data and display it in the image view
            // initially set the upload button to loading, and afterwards change it to ""
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
    
    // if the recipe image button is clicked, allow users to pick the image they want to display
    @IBAction func recipeImageBtn(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    // function that calls that gets the image that users have picked, and assigns to it to the imageview
    // as well as uploading it to the database, and getting the url and saving it
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imageName = NSUUID().uuidString
        
        // variable to hold users selected image
        var selectedImageFromPicker: UIImage?
        let storageRef = Storage.storage().reference().child("\(imageName).png")
        let rootRef = Database.database().reference()

        // if users edits an image assign the edited image to selectedimage
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
        }
        // if users just use original image assign that to selectedimage
        else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        // displays users selected image in the imageview
        if let selectedImage = selectedImageFromPicker {
            recipeImageView.image = selectedImage
            btnUpload.setTitle("", for: .normal)
        }
        
        // uploads users selected image to the databse for future reference
        if let uploadData = UIImagePNGRepresentation(recipeImageView.image!) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if (error != nil) {
                    print("error uploading")
                    return
                }
                print("uploaded")
                
                // gets the url of the uploaded image, and assigns it to the right childs of the user, and recipe
                storageRef.downloadURL(completion: { (url, error) in
                    rootRef.child((UserDefaults.standard.object(forKey: "username") as? String)!).child(self.recipe).setValue([self.recipe, self.cuisine,  url!.absoluteString])
                })
                
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    // if users press cancel on the imagepickercontroller dismiss the view
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    // if users press the url button, it open safari with the recipe url
    @IBAction func btnURL(_ sender: Any) {
        UIApplication.shared.open(URL(string: recipe_URL)!)
    }
    
    // if users press the home button take them back to the rootViewController
    @IBAction func btnHome(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}

