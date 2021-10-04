dynamic class MediaProgressBar extends MovieClip {
	function MediaProgressBar() {
	}
	// end constructor
	
	// ---------------------------------------------------------------------
	// MANAGE MEDIA BUFFER
	//		- called from the presentation to update media buffering
	// ---------------------------------------------------------------------
	function manageMediaBuffer(loaded:Number, total:Number):Void {
		if (loaded != total) {
			this.updateBuffer((loaded/total)*269);
			// if the media is not playing, but it buffering, tell the user
			if (!_root.presentationHolder.placeHolder.presentation.currentSlide.media.playing) {
				this.updateMessage("Buffering Media...");
			}
		} else {
			// when the media finishes loading, move buffer bar all the way and tell user
			this.updateBuffer(269);
			this.updateMessage("Media Loaded");
		}
	}
	// end manageMediaBuffer
	
	// ---------------------------------------------------------------------
	// MANAGE MEDIA BUFFER
	//		- called from the presentation to update media buffering
	// ---------------------------------------------------------------------
	function manageMediaPlay(current:Number, total:Number):Void {
		if (current != total) {
			this.updatePlayer((current/total)*269);
			convertCurrent = current + "";
			convertCurrent = convertCurrent.split(".");
			convertTotal = total + "";
			convertTotal = convertTotal.split(".");
			this.updateMessage(convertCurrent[0]+" / "+convertTotal[0]);
		} else {
			this.updatePlayer(269);
		}
	}
	// end manageMediaPlay
	
	// ---------------------------------------------------------------------
	// ON SLIDER PRESS
	// ---------------------------------------------------------------------
	function onSliderPress():Void {
		// pause the media
		_root.presentationHolder.placeHolder.presentation.currentSlide.media.pause();
		// change to the play position
		_root.playPauseBtn.gotoAndStop("play_mouseout");
	}
	// end onPress
	
	// ---------------------------------------------------------------------
	// ON SLIDER RELEASE
	//		- move the media to the point the user selected
	// ---------------------------------------------------------------------
	function onSliderRelease(sliderXposition:Number):Void {
		// calculate the new play location
		totalTime = _root.presentationHolder.placeHolder.presentation.currentSlide.media.totalTime;
		gotoPlay = (sliderXposition/269)*totalTime;
		// seek the media to the new play position
		_root.presentationHolder.placeHolder.presentation.currentSlide.media.play(gotoPlay);
		// change to the pause position
		_root.playPauseBtn.gotoAndStop("pause_mouseout");
	}
	// end onRelease
	
	// ---------------------------------------------------------------------
	// PLAY PAUSE STATUS
	//		- determine if media is playing when slides switch and then
	//		  adjust the play/pause button accordingly
	// ---------------------------------------------------------------------
	function playPauseStatus():Void {
		if(_root.presentationHolder.placeHolder.presentation.currentSlide.media.playing) {
			_root.playPauseBtn.gotoAndStop("pause_mouseout");
		} else {
			_root.playPauseBtn.gotoAndStop("play_mouseout");
		}
	} // end playPauseStatus
	
	// ---------------------------------------------------------------------
	// UPDATE BUFFER
	//		- updates the buffer progress bar
	// ---------------------------------------------------------------------
	function updateBuffer(xPosition:Number):Void {
		this.preloader._x = xPosition;
	}
	// end updateProgress
	
	// ---------------------------------------------------------------------
	// UPDATE PLAYER
	//		- updates the player progress bar
	// ---------------------------------------------------------------------
	function updatePlayer(xPosition:Number):Void {
		this.playLocation._x = xPosition;
	}
	// end updatePlayer
	
	// ---------------------------------------------------------------------
	// UPDATE MESSAGE
	//		- updates the progress bar message
	// ---------------------------------------------------------------------
	function updateMessage(message:String):Void {
		this.messageText = message;
	}
	// end updateMessage
}
// end class
