//
//  RickMortyTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Mehmet Ozkan on 30.01.2024.
//

import UIKit
import AlamofireImage
class RickMortyTableViewCell: UITableViewCell {
    
    private let customImage: UIImageView = UIImageView()
    private let title: UILabel = UILabel()
    private let gender: UILabel = UILabel()
    private let status: UILabel = UILabel()
    
    private let randomImage: String = "https://picsum.photos/200/300"
    
    enum Identifier: String {
        case custom = "mo"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(customImage)
        addSubview(title)
        addSubview(gender)
        addSubview(status)
        title.textColor = .blue
        title.font = .boldSystemFont(ofSize: 22)
        gender.font = .systemFont(ofSize: 15)
        status.font = .systemFont(ofSize: 15)
        
        customImage.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        title.snp.makeConstraints { (make) in
            make.leading.equalTo(customImage.snp.trailing).offset(10)
            make.top.equalTo(customImage)
        }
        
        gender.snp.makeConstraints { (make) in
            make.leading.equalTo(title)
            make.top.equalTo(title.snp.bottom).offset(-50)
            make.trailing.bottom.equalToSuperview().inset(10)
        }
        
        status.snp.makeConstraints { (make) in
            make.leading.equalTo(gender)
            make.top.equalTo(gender.snp.bottom).offset(-70)
            make.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
    func saveModel(model: Result) {
        title.text = model.name
        gender.text = model.gender
        status.text = model.status
        customImage.af.setImage(withURL: URL(string: model.image ?? randomImage) ?? URL(string: randomImage)!)
    }
    
}
