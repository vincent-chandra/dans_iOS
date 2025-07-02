//
//  FeedView.swift
//  dans_iOS
//
//  Created by Vincent on 02/07/25.
//

import UIKit

class FeedView: UIViewController {
    
    @IBOutlet weak var feedTableView: UITableView!
    
    var presenter: FeedPresenter?
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupTableView()
        
        fetchFeedList(page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                FeedListItem.sharedInstance.feedList.append(contentsOf: data)
                DispatchQueue.main.async {
                    self.feedTableView.reloadData()
                }
            case .failure(let failure):
                print(failure)
                self.showPopUpError()
            }
        }
    }
    
    private func setupTableView() {
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.register(UINib(nibName: "FeedListTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedListTableViewCell")
        feedTableView.showsVerticalScrollIndicator = false
    }
    
    func fetchFeedList(page: Int, completion: @escaping (Result<[FeedEntityList], Error>) -> Void) {
        guard let url = URL(string: "https://picsum.photos/v2/list?page=\(page)&limit=10") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let requestTask = URLSession.shared.dataTask(with: url) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let data = data else {
                print("URLSession dataTask error:", error ?? "")
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            do {
                var feedData = try JSONDecoder().decode([FeedEntityList].self, from: data)
                for (count, _) in feedData.enumerated() {
                    feedData[count].isBookmarked = false
                }
                DispatchQueue.main.async {
                    completion(.success(feedData))
                }
            } catch {
                print("JSONSerialization error:", error)
                completion(.failure(URLError(.cannotDecodeContentData)))
            }
        }
        requestTask.resume()
    }
    
    private func showPopUpError() {
        let alert = UIAlertController(title: "Warning", message: "Failed to parse response from API", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension FeedView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FeedListItem.sharedInstance.feedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedListTableViewCell", for: indexPath) as? FeedListTableViewCell
        let feed = FeedListItem.sharedInstance.feedList[indexPath.row]
        cell?.selectionStyle = .none
        cell?.index = indexPath.row
        cell?.authorName.text = feed.author ?? ""
        cell?.authorImage.loadImage(fromURL: feed.download_url ?? "")
        cell?.isBookmarked = feed.isBookmarked ?? false
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == FeedListItem.sharedInstance.feedList.count {
            page += 1
            
            fetchFeedList(page: page) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    FeedListItem.sharedInstance.feedList.append(contentsOf: data)
                    DispatchQueue.main.async {
                        self.feedTableView.reloadData()
                    }
                case .failure(let failure):
                    print(failure)
                    self.showPopUpError()
                }
            }
        }
    }
}

extension FeedView: FeedListTableCellDelegate {
    func bookmarkButtonTapped(index: Int) {
        FeedListItem.sharedInstance.feedList[index].isBookmarked = !(FeedListItem.sharedInstance.feedList[index].isBookmarked ?? false)
        self.feedTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
    }
}
