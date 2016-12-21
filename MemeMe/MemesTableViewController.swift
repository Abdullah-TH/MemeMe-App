//
//  MemesTableViewController.swift
//  MemeMe
//
//  Created by Abdullah Althobetey on 12/21/16.
//  Copyright © 2016 Abdullah Althobetey. All rights reserved.
//

import UIKit

class MemesTableViewController: UITableViewController
{
    var memes: [Meme]!
    
    let memeCellTextAttributes: [String: Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 14)!,
        NSStrokeWidthAttributeName: -4.0
    ]

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell", for: indexPath) as! MemeTableViewCell
        let meme = memes[indexPath.row]
        
        cell.memeImageView.image = meme.originalImage
        cell.memeLabel.text = meme.topText + "..." + meme.bottomText
        cell.tobLabel.attributedText = NSAttributedString(string: meme.topText, attributes: memeCellTextAttributes)
        cell.bottomLabel.attributedText = NSAttributedString(string: meme.bottomText, attributes: memeCellTextAttributes)

        return cell
    }
 

}









