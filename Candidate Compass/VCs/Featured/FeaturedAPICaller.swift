import Foundation

final class FeaturedAPICaller {
    static let shared = FeaturedAPICaller()
    
    struct Constants {
        static let apiKey = "903452623cf34a849549f580756fe30d"
        static let electionYear = "2024"
        static let electionKeyword = "election"
        static let candidates = ["Joe+Biden", "Donald+Trump", "Robert+Kennedy", "Marianne+Williamson", "Doug+Burgum", "Chris+Christie", "Ron+DeSantis", "Larry+Elder", "Nikki+Haley", "Will+Hurd", "Asa+Hutchinson", "Perry+Johnson", "Mike+Pence", "Vivek+Ramaswamy", "Tim+Scott", "Corey+Stapleton", "Francis+Suarez", "Cornel+West"]
        
        static var topHeadlinesURLs: [URL] {
            var urls: [URL] = []
            for candidate in candidates {
                if let url = URL(string: "https://newsapi.org/v2/everything?apiKey=\(apiKey)&q=\(electionYear)+\(electionKeyword)+\(candidate)") {
                    urls.append(url)
                }
            }
            return urls
        }
    }
    
    private init() {}
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void) {
        let dispatchGroup = DispatchGroup()
        var allArticles: [Article] = []

        for url in Constants.topHeadlinesURLs {
            dispatchGroup.enter()

            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                defer {
                    dispatchGroup.leave()
                }

                if let error = error {
                    print("Error fetching data: \(error)")
                    return
                }

                guard let data = data else {
                    print("No data received")
                    return
                }

                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    allArticles.append(contentsOf: result.articles)
                } catch {
                    print("Decoding error: \(error)")
                }
            }

            task.resume()
        }

        dispatchGroup.notify(queue: .main) {
            completion(.success(allArticles))
        }
    }

}

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article:Codable {
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
    let source: Source
}

struct Source: Codable {
    let name: String
}
