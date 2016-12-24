//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Abdullah Althobetey on 12/22/16.
//  Copyright © 2016 Abdullah Althobetey. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController, MemeEditorVCDelegate
{
    @IBOutlet weak var memeImageView: UIImageView!
    
    var meme: Meme!
    
    override func viewWillAppear(_ animated: Bool)
    {
        memeImageView.image = meme.memedImageImage
    }

    @IBAction func editMeme(_ sender: Any)
    {
        performSegue(withIdentifier: "MemeDetailToMemeEditor", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "MemeDetailToMemeEditor"
        {
            let navController = segue.destination as! UINavigationController
            let memeEditorVC = navController.topViewController as! MemeEditorViewController
            memeEditorVC.topText = meme.topText
            memeEditorVC.bottomText = meme.bottomText
            memeEditorVC.memeImage = meme.originalImage
            memeEditorVC.delegate = self
        }
    }
    
    func memeEditorDidEndEditing()
    {
        dismiss(animated: true, completion: nil)
        _ = navigationController?.popToRootViewController(animated: false)
    }
}




