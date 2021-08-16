//
//  RequestManager.swift
//  Stargazers
//
//  Created by Luigi Audino on 09/08/21.
//

import Foundation

enum RequestError: Error {
    case urlFailed
    case noData
    case requestError
    case parsingFailed
    case notFound
}

enum HttpMethods: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

class RequestManager {
    static let instance = RequestManager()
    
    //https://api.github.com/repos/londonappbrewery/I-Am-Poor-iOS12/stargazers
    func getStargazers(owner: String, repository: String, perPage: Int = 30, page: Int = 1, completion: @escaping (Result<[Stargazer], RequestError>) -> Void) {
        guard var urlComponents = URLComponents(string: "https://api.github.com/repos/\(owner)/\(repository)/stargazers") else {
            print("Non riesco a convertire l'url")
            completion(.failure(.parsingFailed))
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "per_page", value: perPage.description),
            URLQueryItem(name: "page", value: page.description)
        ]
        
        guard let url = urlComponents.url else {
            print("Non riesco a convertire l'url")
            completion(.failure(.parsingFailed))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.GET.rawValue
        
        let header: [String : String] =  ["Accept": "application/json", "Content-Type" : "application/json"]
        
        request.allHTTPHeaderFields = header
        
        print("Request:\(request)")
        
        let session = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if let response = response as? HTTPURLResponse {
                if let _ = error
                {
                    completion(.failure(.requestError))
                    print("REQUEST ERROR URLRESPONSE \(response.statusCode)")
                    
                }
                
                if !response.hasSuccessStatusCode {
                    if(response.statusCode == 404) {
                        completion(.failure(.notFound))
                    }
                    else {
                        completion(.failure(.noData))
                    }
                    
                    print("REQUEST ERROR DATA \(response.statusCode)")
                    return
                }
                
                guard let datas = data else
                {
                    completion(.failure(.noData))
                    print("REQUEST ERROR DATA \(response.statusCode)")
                    return
                    
                }
                
                let responseJson: [Stargazer] = self.parse(data: datas)
                print("DATAS -->\(datas.toString())")
                
                completion(.success(responseJson))
            }
        }
        session.resume()
    }
    
    func parse<T: Decodable>(data: Data) -> T {
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Error: \(error)")
        }
        
    }
}
