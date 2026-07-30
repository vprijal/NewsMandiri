//
//  ArticleCell.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//


import Foundation
import UIKit
import SDWebImage
import SnapKit

class ArticleCell: UICollectionViewCell {
    
    lazy var imageView = UIImageView()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.text = "Month"
        label.textColor = UIColor(named: "#002E4E")
        return label
    }()
    
    var descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 2
        label.text = "Descirption"
        label.textColor = .gray
        return label
    }()
    
    var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.text = "Author"
        label.textColor =  .gray
        return label
    }()
    var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.text = "Date"
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func setupView() {
       setupConstraint()
    }
    
    func setupConstraint() {
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(300)
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(imageView.snp.bottom).offset(12)
        }
        contentView.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-16)
            make.right.equalToSuperview().offset(-12)
            
        contentView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(12)
            make.right.equalTo(dateLabel.snp.left).offset(-4)
        }
        
       
        }
    }
    
    func setData(data: Article) {
        nameLabel.text = data.title
        descLabel.text = data.articleDescription
        authorLabel.text = data.author
        if let url = data.urlToImage, let nsurl = URL(string: url) {
            imageView.sd_setImage(with: nsurl)
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
        
        guard let publishedAt = data.publishedAt else {
            dateLabel.text = ""
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let newDateFormater = DateFormatter()
        newDateFormater.dateFormat = "dd-MMM-yyyy"
        if let theDate = dateFormatter.date(from: publishedAt) {
            dateLabel.text = newDateFormater.string(from: theDate)
        } else {
            let isoFormatter = ISO8601DateFormatter()
            isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            if let theDate = isoFormatter.date(from: publishedAt) {
                dateLabel.text = newDateFormater.string(from: theDate)
            } else {
                dateLabel.text = publishedAt
            }
        }
    }
}
