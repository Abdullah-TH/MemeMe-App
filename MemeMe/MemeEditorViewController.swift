//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Abdullah Althobetey on 12/12/16.
//  Copyright © 2016 Abdullah Althobetey. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate
{
    // MARK: Outlets
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextFeild: UITextField!
    @IBOutlet weak var bottomTextFeild: UITextField!
    
    // MARK: Properties
    let memeTextAttributes: [String: Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -5.0
    ]
    
    var navBar: UINavigationBar!

    // MARK: ViewController Life Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navBar = self.navigationController?.navigationBar
        
        configureTextField(textField: topTextFeild)
        configureTextField(textField: bottomTextFeild)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        enableOrDisableShareButton()
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    
    // MARK: Actions
    
    @IBAction func pickPhoto(_ sender: Any)
    {
        presentImagePicker(withSourceType: .photoLibrary)
    }
    
    @IBAction func pickPhotoFromCamera(_ sender: Any)
    {
        presentImagePicker(withSourceType: .camera)
    }
    
    @IBAction func sharePhoto(_ sender: Any)
    {
        let memedImage = generateMemedImage()
        let activityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        activityVC.completionWithItemsHandler = { (activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, activityError: Error?) in
            
            if completed
            {
                self.save()
            }
            
        }
        
        present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any)
    {
        imageView.image = nil
        topTextFeild.text = "TOP"
        bottomTextFeild.text = "BOTTOM"
        enableOrDisableShareButton()
    }
    
    // MARK: Helper Methods
    
    private func configureTextField(textField: UITextField)
    {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.delegate = self
    }
    
    private func enableOrDisableShareButton()
    {
        shareButton.isEnabled = imageView.image != nil
    }
    
    private func presentImagePicker(withSourceType sourceType: UIImagePickerControllerSourceType)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func generateMemedImage() -> UIImage
    {
        // Hide toolbar and navbar
        navBar.isHidden = true
        toolbar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        navBar.isHidden = false
        toolbar.isHidden = false
        
        return memedImage
    }
    
    private func save()
    {
        // Create the meme
        let meme = Meme(topText: topTextFeild.text!, bottomText: bottomTextFeild.text!, originalImage: imageView.image!, memedImageImage: generateMemedImage())
    }
    
    // MARK: Keyboard Notifications
    
    func subscribeToKeyboardNotifications()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications()
    {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification)
    {
        // Sliding the view up only when the bottom text field is tapped, and also when "self.view.frame.origin.y == 0" to prevent sliding the view up again
        // when the user tap the bottom text filed multible time.
        if bottomTextFeild.isFirstResponder && self.view.frame.origin.y == 0
        {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification: Notification)
    {
        self.view.frame.origin.y = 0.0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat
    {
        let keyboardSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            imageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: UITextFeildDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if textField === topTextFeild
        {
            if textField.text == "TOP"
            {
                textField.text = ""
            }
        }
        else if textField === bottomTextFeild
        {
            if textField.text == "BOTTOM"
            {
                textField.text = ""
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}
















