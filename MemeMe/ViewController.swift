//
//  ViewController.swift
//  MemeMe
//
//  Created by Abdullah Althobetey on 12/12/16.
//  Copyright © 2016 Abdullah Althobetey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate
{
    // MARK: Outlets
    @IBOutlet weak var navigationBar: UINavigationBar!
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
    
    var grayStatusBar: UIView!

    // MARK: ViewController Life Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        topTextFeild.defaultTextAttributes = memeTextAttributes
        topTextFeild.textAlignment = .center
        topTextFeild.delegate = self
        
        bottomTextFeild.defaultTextAttributes = memeTextAttributes
        bottomTextFeild.textAlignment = .center
        bottomTextFeild.delegate = self
        
        // Match the color of the status bar with the navigation bar
        grayStatusBar = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 20.0))
        grayStatusBar.backgroundColor = UIColor(red: 198/255.0, green: 198/255.0, blue: 198/255.0, alpha: 1)
        self.view.addSubview(grayStatusBar)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled = imageView.image != nil
        
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
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickPhotoFromCamera(_ sender: Any)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func sharePhoto(_ sender: Any)
    {
        let memedImage = generateMemedImage()
        let activityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any)
    {
        imageView.image = nil
        topTextFeild.text = "TOP"
        bottomTextFeild.text = "BOTTOM"
    }
    
    // MARK: Save/Share Meme Images
    
    func generateMemedImage() -> UIImage
    {
        // Hide toolbar, navbar and gray status bar
        navigationBar.isHidden = true
        toolbar.isHidden = true
        grayStatusBar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbar, navbar and gray status bar
        navigationBar.isHidden = false
        toolbar.isHidden = false
        grayStatusBar.isHidden = false
        
        return memedImage
    }
    
     // TODO: To be used in MemeMe 2.0
//    func save()
//    {
//        // Create the meme
//        let meme = Meme(topText: topTextFeild.text!, bottomText: bottomTextFeild.text!, originalImage: imageView.image!, memedImageImage: generateMemedImage())
//    }
    
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
        return true;
    }
}
















