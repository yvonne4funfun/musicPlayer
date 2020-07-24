//
//  ViewController.swift
//  musicPlayer
//
//  Created by 黃芳致 on 2020/7/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var backgroundColor: UIView!
    @IBOutlet weak var musicNmame: UILabel!
    @IBOutlet weak var singer: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var songLength: UILabel!
    @IBOutlet weak var musicImageView: UIImageView!
    @IBOutlet weak var musicSlider: UISlider!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    var player = AVPlayer()
    //AVPlayer 可以播放音訊跟影片，製作一個AVPlayer物件。
    var playerItem:AVPlayerItem?
    //抓取音樂總長度及播放進度
    var playIndex = 0
    
    
    
    
    
    
    override func viewDidLoad() {
        backgroundView()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let fileUrl = Bundle.main.url(forResource: "漂洋過海來看你",withExtension: "mp3")!
        playerItem = AVPlayerItem(url: fileUrl)
        musicNmame.text = "漂洋過海來看你"
        singer.text = "中山陳綺貞"
         musicImageView.image = UIImage(named: "playGuitar.jpg")
        CurrentTime()
        updatePlayerUI()
        playIndex = 0}
    //在viewDidLoad內將需要的檔案放置專案內，利用Bundle.main 取得，呼叫function url，參數 forResource打上檔名，參數 withExtension 打上附檔名
    
    
        
        func formatConversion(time:Float64)->String{
            let songLength = Int(time)
            let minutes = Int(songLength / 60)
            let seconds = Int(songLength % 60)
            var time = ""
            if minutes < 10 {
                time = "0\(minutes):"
            }else{
                time = "\(minutes)"
            }
            if seconds < 10 {
                time += "0\(seconds)"
            }else{
                time = time+"\(seconds)"
            }
            return time
        }
        //設定音樂時間秒數格式
        
        
        
        
        
        
        func CurrentTime(){
            player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main, using: {(CMTime)in
                if self.player.currentItem?.status == .readyToPlay{
                    let currentTime = CMTimeGetSeconds(self.player.currentTime())
                    self.musicSlider.value = Float(currentTime)
                    self.currentLabel.text = self.formatConversion(time:currentTime)
                }
                
            })
        }
        //計算當前時間，更新slider跟歌曲目前時間的label
        
        
        func updatePlayerUI() {
            guard let duration = playerItem?.asset.duration else {
                return
            }
            let second = CMTimeGetSeconds(duration)
            songLength.text = formatConversion(time: second)
        // 把 duration 轉為我們歌曲的總時間（秒數）。

            musicSlider.minimumValue = 0
            musicSlider.maximumValue = Float(second)
            musicSlider!.isContinuous = true
            //如果想要拖動後才更新進度，那就設為 false；如果想要直接更新就設為 true，預設為 true。
            
            
        }
        
        
        
        
        
        
    


    @IBAction func playButton(_ sender: UIButton) {
        player.replaceCurrentItem(with: playerItem)
        
        if player.rate == 0 {
            playButton.setImage(UIImage(named: "pause.png"), for: .normal)
            player.play()
        }else{
            playButton.setImage(UIImage(named: "play.png"), for: .normal)
            player.pause()
        }

    }
//根據播放的 rate （ 播放速率 ），來判斷他是否正在播放
    
    @IBAction func nextButton(_ sender: UIButton) {
        let fileUrl = Bundle.main.url(forResource: "情歌", withExtension: "mp3")!
        playerItem = AVPlayerItem(url: fileUrl)
        musicImageView.image = UIImage(named: "image2.jpg")
        musicNmame.text = "情歌"
        singer.text = "中山陳綺貞"
        updatePlayerUI()
        CurrentTime()
        player.replaceCurrentItem(with: playerItem)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
    let fileUrl = Bundle.main.url(forResource: "漂洋過海來看你",withExtension: "mp3")!
    playerItem = AVPlayerItem(url: fileUrl)
    musicNmame.text = "漂洋過海來看你"
        musicImageView.image = UIImage(named: "playGuitar.jpg")
    singer.text = "中山陳綺貞"
    CurrentTime()
    updatePlayerUI()
        player.replaceCurrentItem(with: playerItem)
    }
    
    @IBAction func slider(_ sender: UISlider) {
        let seconds = Int64(musicSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        player.seek(to: targetTime)
        //將當前設置時間設為播放時間

    }
    
    
    func backgroundView(){
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = backgroundColor.bounds
    gradientLayer.colors = [CGColor(srgbRed: 67/255, green: 67/255, blue: 67/255, alpha: 1),CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)]
    backgroundColor.layer.insertSublayer(gradientLayer, at: 0)
    }
    //自訂的背景漸層function

}

