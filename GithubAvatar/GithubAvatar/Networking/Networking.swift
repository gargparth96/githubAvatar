//
//  Networking.swift
//  GithubAvatar
//
//  Created by Parth Garg on 10/05/21.
//

import Foundation

typealias SearchQueryResponse = ((_ response: SearchResponse?, _ error: Error?) -> Void)
typealias FollowersResponse = ((_ response: [UserDetails]?, _ error: Error?) -> Void)

class Networking {

    static let sharedInstance = Networking()
    private let searchURLString = "https://api.github.com/search/users?q="

    private init() { }

    func getUsersMatchingSearchedQuery(_ query: String, _ completion: @escaping SearchQueryResponse) {

        let transformedUrlString = searchURLString + query
        guard let url = URL(string: transformedUrlString) else {
            assertionFailure("unable to form URL")
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "accept")
        let urlSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        dataTask?.cancel()
        dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
            defer {
                dataTask = nil
            }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

            guard let data = data,
                  let responseData = try? jsonDecoder.decode(SearchResponse.self, from: data) else {
                DispatchQueue.main.async {
                    completion(nil, error)
                    return
                }
                return
            }
            DispatchQueue.main.async {
                completion(responseData, nil)
            }
        }
        dataTask?.resume()
    }

    func getFollowersForUser(usingUrl followersUrl: String, _ completion: @escaping FollowersResponse) {

        guard let url = URL(string: followersUrl) else {
            assertionFailure("unable to form URL")
            return
        }

        let urlRequest = URLRequest(url: url)
        let urlSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        dataTask?.cancel()
        dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
            defer {
                dataTask = nil
            }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

            guard let data = data,
                  let responseData = try? jsonDecoder.decode([UserDetails].self, from: data) else {
                DispatchQueue.main.async {
                    completion(nil, error)
                    return
                }
                return
            }
            DispatchQueue.main.async {
                completion(responseData, nil)
            }
        }
        dataTask?.resume()
    }

    func getRawData(from urlString: String, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {

        guard let url = URL(string: urlString) else {
            completion(nil, nil, nil)
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
