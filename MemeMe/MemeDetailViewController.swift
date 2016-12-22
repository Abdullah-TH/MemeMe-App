//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Abdullah Althobetey on 12/22/16.
//  Copyright © 2016 Abdullah Althobetey. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController
{
    @IBOutlet weak var memeImageView: UIImageView!
    
    var memedImage: UIImage!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        memeImageView.image = memedImage
    }

    @IBAction func editMeme(_ sender: Any)
    {
        
    }
}




