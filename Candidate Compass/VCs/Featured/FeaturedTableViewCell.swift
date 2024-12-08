import UIKit

class FeaturedTableViewCellModel {
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(
        title: String,
        subtitle: String,
        imageURL: URL?
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
}

class FeaturedTableViewCell: UITableViewCell {
    static let identifier = "FeaturedTableViewCell"
    
    private let newsTitleLabel: UILabel = {
       let label = UILabel()
       label.numberOfLines = 0
       label.font = UIFont(name: "Arvo", size: 15)
       return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .systemBackground
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsTitleLabel.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width - 200, height: 150)
        newsImageView.frame = CGRect(x: contentView.frame.size.width - 165, y: 5, width: 150, height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        newsImageView.image = nil
    }
    
    func configure(with viewModel: FeaturedTableViewCellModel) {
        let correctedTitle = viewModel.title.replacingOccurrences(of: "iktok", with: "Tiktok", options: .caseInsensitive)
        newsTitleLabel.text = correctedTitle
        
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageURL{
            //fetch image
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}

