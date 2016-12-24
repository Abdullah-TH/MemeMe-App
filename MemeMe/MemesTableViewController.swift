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
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var memes: [Meme]!
    var noMemesImageView = UIImageView()
    
    let memeCellTextAttributes: [String: Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 14)!,
        NSStrokeWidthAttributeName: -4.0
    ]
    
    // MARK: - View Controller life cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        memes = appDelegate.memes
        tableView.reloadData()
        toggleNoMemesView()
        self.editButtonItem.isEnabled = memes.count > 0
    }
    
    // MARK: - Helper methods 
    
    private func toggleNoMemesView()
    {
        if memes.count == 0
        {
            noMemesImageView.image = UIImage(named: "no_memes")
            noMemesImageView.contentMode = .scaleAspectFill
            noMemesImageView.translatesAutoresizingMaskIntoConstraints = false
            self.navigationController?.view.insertSubview(noMemesImageView, belowSubview: (self.navigationController?.navigationBar)!)
            let topConstraint = NSLayoutConstraint(item: noMemesImageView, attribute: .top, relatedBy: .equal, toItem: self.navigationController?.view, attribute: .top, multiplier: 1, constant: 0)
            let bottomConstaint = NSLayoutConstraint(item: noMemesImageView, attribute: .bottom, relatedBy: .equal, toItem: self.navigationController?.view, attribute: .bottom, multiplier: 1, constant: 0)
            let leadingConstraint = NSLayoutConstraint(item: noMemesImageView, attribute: .leading, relatedBy: .equal, toItem: self.navigationController?.view, attribute: .leading, multiplier: 1, constant: 0)
            let trailingConstaint = NSLayoutConstraint(item: noMemesImageView, attribute: .trailing, relatedBy: .equal, toItem: self.navigationController?.view, attribute: .trailing, multiplier: 1, constant: 0)
            navigationController?.view.addConstraints([topConstraint, bottomConstaint, leadingConstraint, trailingConstaint])
        }
        else
        {
            noMemesImageView.removeFromSuperview()
        }
    }
    
    // MARK: - Navigation 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "MemesTableToDetail"
        {
            let memeDetailVC = segue.destination as! MemeDetailViewController
            let indexPath = sender as! IndexPath
            memeDetailVC.meme = memes[indexPath.row]
            memeDetailVC.hidesBottomBarWhenPushed = true
        }
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
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "MemesTableToDetail", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            memes.remove(at: indexPath.row)
            appDelegate.memes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            toggleNoMemesView()
        }
        
        if memes.count == 0
        {
            self.setEditing(false, animated: true)
            self.editButtonItem.isEnabled = false
        }
    }
 

}









