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
    
    let memeCellTextAttributes: [String: Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 14)!,
        NSStrokeWidthAttributeName: -4.0
    ]
    
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
        
    }

}













