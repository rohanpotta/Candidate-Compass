import Foundation

final class YoutubeAPIResponse {
    
    static let shared = YoutubeAPIResponse()
    
    private init() {}
    
    func getVideos(keyword: String, completion: @escaping (Result<[VideoItem], Error>) -> Void) {
        guard let url = youtubeURL(withKeyword: keyword) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(VideosAPIResponse.self, from: data)
                    completion(.success(result.items))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    private func youtubeURL(withKeyword keyword: String) -> URL? {
        let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let today = Date()
        let calendar = Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: calendar.startOfDay(for: today)))
        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth!)!

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let startISO = dateFormatter.string(from: startOfMonth!)
        let endISO = dateFormatter.string(from: endOfMonth)
        let urlString = "https://www.googleapis.com/youtube/v3/search?key=AIzaSyDRbfZCjfaYB1uighCRcaICFpKW3F8We3Y&part=snippet&maxResults=20&q=\(encodedKeyword)%20News&publishedAfter=\(startISO)&publishedBefore=\(endISO)"
        return URL(string: urlString)
    }
}

struct VideoItem: Codable {
    let snippet: Snippet
    let id: VideoId
    
    enum CodingKeys: String, CodingKey {
        case snippet
        case id
    }
}

struct VideoId: Codable {
    let videoId: String?
    
    enum CodingKeys: String, CodingKey {
        case videoId = "videoId"
    }
}

struct VideosAPIResponse: Codable {
    let items: [VideoItem]
}

struct Snippet: Codable {
    let title: String
    let publishedAt: String
    let thumbnails: Thumbnails
}

struct Thumbnails: Codable {
    let medium: ThumbnailDetail
    
    struct ThumbnailDetail: Codable {
        let url: String
    }
}
