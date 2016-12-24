//
//  MemesCollectionViewController.swift
//  MemeMe
//
//  Created by Abdullah Althobetey on 12/21/16.
//  Copyright © 2016 Abdullah Althobetey. All rights reserved.
//

import UIKit


class MemesCollectionViewController: UICollectionViewController
{
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    
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
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        collectionView?.reloadData()
        toggleNoMemesView()
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
        if segue.identifier == "MemesCollectionToDetail"
        {
            let memeDetailVC = segue.destination as! MemeDetailViewController
            let indexPath = sender as! IndexPath
            memeDetailVC.meme = memes[indexPath.row]
            memeDetailVC.hidesBottomBarWhenPushed = true
        }
    }

    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        
        cell.memeImageView.image = meme.originalImage
        cell.topLabel.attributedText = NSAttributedString(string: meme.topText, attributes: memeCellTextAttributes)
        cell.bottomLabel.attributedText = NSAttributedString(string: meme.bottomText, attributes: memeCellTextAttributes)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "MemesCollectionToDetail", sender: indexPath)
    }

}













