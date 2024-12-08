import UIKit

class ForYouVideosTableViewCell: UITableViewCell {
    static let identifier = "VideoTableViewCell"
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        
        thumbnailImageView.frame = CGRect(x: 10, y: 10, width: 120, height: 80)
        titleLabel.frame = CGRect(x: thumbnailImageView.frame.maxX + 10, y: 10, width: contentView.frame.width - thumbnailImageView.frame.width - 20, height: 40)
        dateLabel.frame = CGRect(x: thumbnailImageView.frame.maxX + 10, y: titleLabel.frame.maxY + 5, width: contentView.frame.width - thumbnailImageView.frame.width - 20, height: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        dateLabel.text = nil
        thumbnailImageView.image = nil
    }
    
    func configure(with model: VideoItem) {
        if let decodedTitle = model.snippet.title.htmlDecoded {
                titleLabel.text = decodedTitle
            } else {
                titleLabel.text = model.snippet.title
            }
        dateLabel.text = model.snippet.publishedAt
        
        if let thumbnailUrl = URL(string: model.snippet.thumbnails.medium.url) {
            URLSession.shared.dataTask(with: thumbnailUrl) { [weak self] (data, _, _) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.thumbnailImageView.image = image
                    }
                }
            }.resume()
        }
    }
}
