//
//  ChatLogController.swift
//  FBMessanger
//
//  Created by Alaa_Naji on 7/17/16.
//  Copyright © 2016 Alaa_Naji. All rights reserved.
//

import UIKit

class ChatLogController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    private var cellId = "cellId"
    var friend:Friend? {
        didSet{
            navigationItem.title = friend?.name
            messeges = friend?.messeges?.allObjects as? [Message]
            messeges = messeges?.sort({$0.date!.compare($1.date!) == .OrderedAscending})
        }
    }
    var messeges:[Message]?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerClass(ChatLogMessageCell.self, forCellWithReuseIdentifier: cellId)
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messeges?.count {
            return count
        }
        return 0
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! ChatLogMessageCell
        if let msgTxt = messeges![indexPath.item].text , profileImageName = messeges![indexPath.item].friend?.profileImageName {
            cell.profileImageView.image = UIImage(named: profileImageName)
            let size = CGSizeMake(250, 1000)
            let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
            let estmatedFrame = NSString(string: msgTxt).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(18)], context: nil)
            cell.textView.frame = CGRectMake(48, 0, estmatedFrame.width+16+8, estmatedFrame.height+20)
            cell.txtBuble.frame = CGRectMake(48, 0, estmatedFrame.width+16+8, estmatedFrame.height+20)
            cell.txtBuble.text = msgTxt
        }
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if let msgTxt = messeges![indexPath.item].text {
            let size = CGSizeMake(250, 1000)
            let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
            let estmatedFrame = NSString(string: msgTxt).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(18)], context: nil)
            return CGSizeMake(view.frame.width, estmatedFrame.height+20)
        }
        return CGSizeMake(view.frame.width, 100)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
}

class ChatLogMessageCell: BaseCell {
    
    let textView:UITextView = {
        let txt = UITextView()
        txt.backgroundColor = UIColor.clearColor()
        return txt
    }()
    let txtBuble:UITextView = {
        let text = UITextView()
        text.layer.cornerRadius = 15
        text.layer.masksToBounds = true
        text.font = UIFont.systemFontOfSize(18)
        text.backgroundColor = UIColor(white: 0.95, alpha: 1)
        return text
    }()
    let profileImageView:UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.layer.masksToBounds = true
        return image
    }()
    override func setupView() {
        super.setupView()
        
        addSubview(textView)
        addSubview(txtBuble)
        addSubview(profileImageView)
        addConstraintsWithFromat("H:|-8-[v0(30)]", views: profileImageView)
        addConstraintsWithFromat("V:[v0(30)]|", views: profileImageView)
//        addConstraintsWithFromat("H:|[v0]|", views: textView)
//        addConstraintsWithFromat("V:|[v0]|", views: textView)
    }
}