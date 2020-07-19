//
//  detailsCell.swift
//  TechMahindraTask
//
//  Created by Venkatesh on 18/07/20.
//  Copyright © 2020 Venkatesh. All rights reserved.
//

import Foundation
import UIKit

class detailsCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupViews()
    }
    var factDetailsDict: Rows? = nil {
        didSet{
            titleLbl.text = factDetailsDict?.title ?? ""
            descriptionLbl.text = factDetailsDict?.description ?? ""
            if factDetailsDict!.imageHref != nil {
                imageVw.downloaded(from: factDetailsDict!.imageHref!)
            }else{
                imageVw.image = UIImage(named: "image_placeholder")
            }
        }
    }
    
    let cellHeaderView: UIView = {
        let headerVw = UIView()
        headerVw.translatesAutoresizingMaskIntoConstraints = false
        headerVw.layer.cornerRadius = 5
        headerVw.layer.masksToBounds = false
        headerVw.layer.borderWidth = 0.5
        headerVw.layer.borderColor = UIColor.lightGray.cgColor
        headerVw.layer.shadowColor = UIColor.gray.cgColor
        headerVw.layer.shadowOffset = CGSize(width: 5, height: 5)
        headerVw.layer.shadowRadius = 5
        headerVw.layer.shadowOpacity = 5
        headerVw.backgroundColor = UIColor.white
        return headerVw
    }()
    
    let imageVw: UIImageView = {
        let imageVw = UIImageView()
        imageVw.translatesAutoresizingMaskIntoConstraints = false
        return imageVw
    }()
    
    let titleLbl: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor.black
        label.text = ""
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    let descriptionLbl: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.numberOfLines = 0
        label.backgroundColor = UIColor.clear
        label.sizeToFit()
        return label
    }()
    
    //MARK:- SETUP VIEWS
    func setupViews(){
        let padding: CGFloat = 5
        let imageWidth:CGFloat = 100
        contentView.addSubview(cellHeaderView)
        cellHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        cellHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding).isActive = true
        cellHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
        cellHeaderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding).isActive = true
        
        //Image view
        cellHeaderView.addSubview(imageVw)
        imageVw.leadingAnchor.constraint(equalTo: cellHeaderView.leadingAnchor, constant:padding).isActive = true
        imageVw.topAnchor.constraint(equalTo: cellHeaderView.topAnchor, constant:padding).isActive = true
        imageVw.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
        imageVw.heightAnchor.constraint(equalToConstant: imageWidth).isActive = true
        imageVw.bottomAnchor.constraint(equalTo: cellHeaderView.bottomAnchor, constant: -padding).isActive = true
        imageVw.contentMode = .scaleAspectFill
        imageVw.layer.cornerRadius = 5
        imageVw.layer.masksToBounds = true
//        //TITLE LABEL
        cellHeaderView.addSubview(titleLbl)
        titleLbl.leadingAnchor.constraint(equalTo: imageVw.trailingAnchor, constant:10).isActive = true
        titleLbl.topAnchor.constraint(equalTo: imageVw.topAnchor, constant: 0).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -10).isActive = true
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
//        //DESCRIPTION LABEL
        cellHeaderView.addSubview(descriptionLbl)
        descriptionLbl.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor, constant:0).isActive = true
        descriptionLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: padding).isActive = true
        descriptionLbl.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: 0).isActive = true
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        descriptionLbl.bottomAnchor.constraint(equalTo: imageVw.bottomAnchor, constant: 0).isActive = true

    }
}

