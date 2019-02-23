//
//  ViewController.swift
//  NewsFeed
//
//  Created by Andrii Pyvovarov on 2/14/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import UIKit
import SafariServices

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var refreshControl : UIRefreshControl?
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var tableView: UITableView!
    var feeds: [NewsPost] = []
    var filteredFeeds : [NewsPost] = []
    let cellId = "cellId"
    var limit = 4
    var searchActive : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        navBar()
        searchControl()
        addRefreshControl()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }

    private func navBar(){
        navigationItem.title = "News Feed"
        let nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(r: 32, g: 72, b: 122)
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(r: 220, g: 240, b: 44), NSAttributedString.Key.font: UIFont(name: "CourierNewPS-BoldItalicMT", size: 24)!]
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(r: 220, g: 240, b: 44)
    }
    
   
    func addRefreshControl(){
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = UIColor.blue
        refreshControl?.addTarget(self, action: #selector(updateData), for: .valueChanged)
        tableView.addSubview(refreshControl!)
    }
    @objc func fetchData(){
        feeds = []
        let feedClient = OpenNewsFeedClient()
        DispatchQueue.global(qos: .background).async {
            feedClient.requestFeed { (feeds) in
                self.feeds = feeds
                DispatchQueue.main.async {
                    self.tableView.reloadSections(IndexSet(integer: 0), with: .left)
                }
            }
        }
    }
    
    
    private func searchControl()  {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        searchController.searchBar.tintColor = UIColor.blue
        definesPresentationContext = true
    }
    private func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }

    private func filterContentForSearchText(_ searchText: String, scope: String = "Title") {
        filteredFeeds = feeds.filter({( post : NewsPost) -> Bool in
            return post.title.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }

    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    private func arrayData() -> [NewsPost]? {
        return isFiltering() ? filteredFeeds : feeds
    }
    @objc func updateData(){
        let feedClient = OpenNewsFeedClient()
        DispatchQueue.global(qos: .background).async {
            feedClient.requestFeed(completionHandler: { (newFeeds) in
                self.feeds = newFeeds
            })
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering(){
            return filteredFeeds.count
        }
        
        return feeds.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! FeedTableViewCell
        if isFiltering(){
            cell.title.text = filteredFeeds[indexPath.row].title
            cell.source.text = filteredFeeds[indexPath.row].source
            cell.author.text = filteredFeeds[indexPath.row].author
            cell.profileImageView.downloadedForLink(from: filteredFeeds[indexPath.row].imageUrl)
            cell.descript.text = filteredFeeds[indexPath.row].descript
            cell.dateOfPublication.text = filteredFeeds[indexPath.row].publishedAt
            cell.url = filteredFeeds[indexPath.row].url
            
        } else {
            cell.title.text = feeds[indexPath.row].title
            cell.source.text = feeds[indexPath.row].source
            cell.author.text = feeds[indexPath.row].author
            cell.profileImageView.downloadedForLink(from: feeds[indexPath.row].imageUrl)
            cell.descript.text = feeds[indexPath.row].descript
            cell.dateOfPublication.text = feeds[indexPath.row].publishedAt
            cell.url = feeds[indexPath.row].url
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let href = arrayData()![indexPath.row].url
        
        let svc = SFSafariViewController(url: URL(string: href)!)
        
        DispatchQueue.main.async {
            tableView.reloadData()
        }
        
        self.present(svc, animated: true, completion: nil)
    }
}

extension MainViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        filterContentForSearchText(searchController.searchBar.text!)
    }
}



