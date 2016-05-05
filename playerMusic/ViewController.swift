//
//  ViewController.swift
//  playerMusic
//
//  Created by Mael on 2/5/16.
//  Copyright © 2016 Mael T. All rights reserved.
//



import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    
    //Buttons
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var songPicker: UIPickerView!
    @IBOutlet weak var playButton: UIButton!
    
    //Control volume
    @IBOutlet weak var volumenSlider: UISlider!
    
    
    //About song
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var discLabel: UILabel!
    @IBOutlet weak var cover: UIImageView!
    
    
    
    
    private var myPlayer: AVAudioPlayer!
    
    let listSongs: ListSongs = ListSongs()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.songPicker.selectRow(3, inComponent: 0, animated: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let ind = self.songPicker.selectedRowInComponent(0)
        
        
        self.songLabel.text = self.listSongs.music[ind].title
        self.authorLabel.text = self.listSongs.music[ind].author
        self.discLabel.text = self.listSongs.music[ind].disc
        self.cover.image = self.listSongs.music[ind].cover
        
        
        let soundURL = NSBundle.mainBundle().URLForResource(self.listSongs.music[ind].fileSong, withExtension: "mp3")
        do{
            try myPlayer = AVAudioPlayer(contentsOfURL: soundURL!)
            self.myPlayer.delegate = self
        }catch{
            print("Error al cargar la canción")
        }
        
        
        self.volumenSlider.value = myPlayer.volume
        
        
    }
    
    func changeSong(nextSong: Int){
        
        self.stop()
        self.songPicker.selectRow(nextSong, inComponent: 0, animated: true)
        self.cover.image = self.listSongs.music[nextSong].cover
        
        self.songLabel.text = self.listSongs.music[nextSong].title
        self.authorLabel.text = self.listSongs.music[nextSong].author
        self.discLabel.text = self.listSongs.music[nextSong].disc
        let soundURL = NSBundle.mainBundle().URLForResource(self.listSongs.music[nextSong].fileSong, withExtension: "mp3")
        do{
            try myPlayer = AVAudioPlayer(contentsOfURL: soundURL!)
            myPlayer.volume = self.volumenSlider.value
            
            self.play()
            
            self.myPlayer.delegate = self
        }catch{
            print("Error al cargar la canción")
        }
        
    }
    
    
    @IBAction func play() {
        
        if !myPlayer.playing{
            myPlayer.play()
            self.playButton.setImage(UIImage(named: "play"), forState: UIControlState.Normal)
            
        }
    }
    
    @IBAction func pause() {
        if myPlayer.playing{
            myPlayer.pause()
            self.playButton.setImage(UIImage(named: "playing"), forState: UIControlState.Normal)
        }
    }
    
    
    @IBAction func stop() {
        myPlayer.stop()
        myPlayer.currentTime = 0
        self.playButton.setImage(UIImage(named: "play"), forState: UIControlState.Normal)
        
    }
    
    
    @IBAction func shuffle() {
        
        self.listSongs.music.shuffle()
        self.songPicker.reloadComponent(0)
        self.songPicker.selectRow(0, inComponent: 0, animated: true)
        self.changeSong(0)
        
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully
        flag: Bool) {
        
        if(self.songPicker.selectedRowInComponent(0)<self.listSongs.music.count-1){
            let nextSong = self.songPicker.selectedRowInComponent(0) + 1
            self.changeSong(nextSong)
        }else{
            self.playButton.hidden = false
            self.pauseButton.hidden = true
        }
    }
    
    
    @IBAction func controlVolume(sender: UISlider) {
        myPlayer.volume = sender.value
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.listSongs.music.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        return self.listSongs.music[row].title
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.changeSong(row)
    }
    
    
}


