//
//  ViewController.swift
//  FBMessanger
//
//  Created by Alaa_Naji on 7/16/16.
//  Copyright © 2016 Alaa_Naji. All rights reserved.
//

import UIKit

class FriendController: UICollectionViewController , UICollectionViewDelegateFlowLayout{

    private var cellId = "cellId"
    var msg:[Message]?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.alwaysBounceVertical = true
        collectionView?.registerClass(MSGCell.self, forCellWithReuseIdentifier: cellId)
        setupData()
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = msg?.count {
            return count
        }
        return 0
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as? MSGCell
        if let messege = msg?[indexPath.item] {
            cell!.MSG = messege
        }
        return cell!
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(view.frame.width, 100)
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let layout = UICollectionViewFlowLayout()
        let friendChat = ChatLogController(collectionViewLayout: layout)
        friendChat.friend = msg![indexPath.item].friend
        navigationController?.pushViewController(friendChat, animated: true)
    }

}
class MSGCell: BaseCell {
    
    var MSG:Message?
        {
        didSet{
        lblName.text = MSG!.friend?.name
        lblMessage.text = MSG!.text
            if let profileImageName = MSG!.friend?.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
                hasReadImageView.image = UIImage(named: profileImageName)
            }
            let date = MSG!.date
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            lblTime.text = dateFormatter.stringFromDate(date!)
        }
    }
    let profileImageView:UIImageView = {
       let image = UIImageView()
        image.contentMode = .ScaleAspectFill
        image.layer.cornerRadius = 34
        image.layer.masksToBounds = true
        return image
    }()
    
    let hasReadImageView:UIImageView = {
        let image = UIImageView()
        image.contentMode = .ScaleAspectFill
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        return image
    }()
    let dividerLine:UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
       return line
    }()
    let lblName:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(18)
        return label
    }()
    let lblMessage:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(14)
        return label
    }()
    let lblTime:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(14)
        return label
    }()
    override func setupView() {
        
        addSubview(profileImageView)
        addSubview(dividerLine)
        setupContainer()

        //profileImageView Constraints
        addConstraintsWithFromat("H:|-12-[v0(68)]", views: profileImageView)
        addConstraintsWithFromat("V:[v0(68)]", views: profileImageView)
        addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
        //dividerLine Constraints
        addConstraintsWithFromat("H:|-82-[v0]|", views: dividerLine)
        addConstraintsWithFromat("V:[v0(1)]|", views: dividerLine)

    }
    func setupContainer() {
        
        let container = UIView()
        addSubview(container)
        //Container Constraints
        addConstraintsWithFromat("H:|-90-[v0]|", views: container)
        addConstraintsWithFromat("V:[v0(50)]", views: container)
        addConstraint(NSLayoutConstraint(item: container, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
        container.addSubview(lblName)
        container.addSubview(lblMessage)
        container.addSubview(lblTime)
        container.addSubview(hasReadImageView)
        //lblName Constraints
        container.addConstraintsWithFromat("H:|[v0][v1(80)]-12-|", views: lblName,lblTime)
        container.addConstraintsWithFromat("V:|[v0][v1(24)]", views: lblName,lblMessage)
        //lblMessage Constraints
        container.addConstraintsWithFromat("H:|[v0]-8-[v1(20)]-12-|", views: lblMessage,hasReadImageView)
        //lblTime Constraints
        container.addConstraintsWithFromat("V:|[v0(24)]", views: lblTime)
        //hasReadMessage Constraints
        container.addConstraintsWithFromat("V:[v0(20)]|", views: hasReadImageView)
    }
}
extension UIView {
    func addConstraintsWithFromat(format:String,views:UIView...) {
        
        var viewDictionary = [String:UIView]()
        for (index,view) in views.enumerate(){
            let key = "v\(index)"
            viewDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
    }
}
class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView() {
        

    }
}
