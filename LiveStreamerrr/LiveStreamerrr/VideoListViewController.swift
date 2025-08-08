//
//  ViewController.swift
//  LiveStreamerrr
//
//  Created by Roderick Presswood on 7/24/25.
//

import UIKit
import AVKit

class VideoListViewController: UIViewController {
    private var videos: [Video] = []
    private let tableView = UITableView()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "VideoStreamerrr"
        view.backgroundColor = .systemBackground
        setupTableView()
        fetchVideos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        coordinator.animate { _ in
//            self.view.setNeedsLayout()
//            self.view.layoutIfNeeded()
//        }
//    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchVideos() {
        VideoService.shared.fetchVideos { [weak self] videos in
            self?.videos = videos
            self?.tableView.reloadData()
        }
    }
}

extension VideoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let video = videos[indexPath.row]
        cell.textLabel?.text = "Video ID: \(video.id)"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let video = videos[indexPath.row]
        if let file = video.videoFiles.first, let url = URL(string: file.link) {
            let player = AVPlayer(url: url)
            let vc = AVPlayerViewController()
            vc.player = player
            present(vc, animated: true)
            player.play()
        }
    }
}
