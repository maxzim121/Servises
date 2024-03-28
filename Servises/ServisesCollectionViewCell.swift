import UIKit

final class ServisesCollectionViewCell: UICollectionViewCell {
    
    lazy var icon: UIImageView = {
        var icon = UIImageView()
        icon.tintColor = .white
        return icon
    }()
    
    lazy var nameLabel: UILabel = {
        nameLabel = UILabel()
        nameLabel.textColor = .white
        return nameLabel
    }()
    
    lazy var descriptionLabel: UILabel = {
        descriptionLabel = UILabel()
        descriptionLabel.textColor = .white
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 3
        return descriptionLabel
    }()
    
    lazy var chevronIcon: UIImageView = {
        var chevronIcon = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevronIcon.tintColor = .gray
        chevronIcon.contentMode = .scaleAspectFit
        return chevronIcon
    }()
    
    lazy var link: String = {
        var link = ""
        return link
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        [icon, nameLabel, descriptionLabel, chevronIcon].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            icon.widthAnchor.constraint(equalToConstant: 70),
            icon.heightAnchor.constraint(equalToConstant: 70),
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            chevronIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            chevronIcon.widthAnchor.constraint(equalToConstant: 20),
            chevronIcon.heightAnchor.constraint(equalToConstant: 20),
            chevronIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: icon.topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: chevronIcon.leadingAnchor, constant: 5),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: chevronIcon.leadingAnchor, constant: -5),
            descriptionLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 16),
        ])
    }
    
}
