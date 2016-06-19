// ----------------------------------------------
//  Media Listeners
//		- set of listeners that trigger functions
//		  of the presentation player
// ----------------------------------------------

// create new listener object
listener = new Object();

// manage the cuepoints
listener.cuePoint = function(eventObj) {
	if (eventObj.target.name.indexOf("sub") == 0) {
		trace("subtitle");
		_root.subtitlesHolder.holder.subtitles = _parent.currentSlide[eventObj.target.name];
	} else {
		// make sure the cuepoint and the frame label match!
		_parent.currentSlide.gotoAndPlay(eventObj.target.name);
	}
}
media.addEventListener("cuePoint", listener);

// manage the buffering and loading of the media
listener.progress = function(eventObj) {
	_root.mediaProgressBar.manageMediaBuffer(media.bytesLoaded, media.bytesTotal);
};
media.addEventListener("progress", listener);

// manage the play location of the media
listener.change = function(eventObj) {
	_root.mediaProgressBar.manageMediaPlay(media.playheadTime, media.totalTime);
};
media.addEventListener("change", listener);

// when the media finished playing
listener.complete = function(eventObj) {
	media.stop();
	_root.presentationHolder.placeHolder.presentation.currentSlide.gotoNextSlide();
	_root.chapterList.chapterListHolder.moveHighlight(1);
	_root.chapterList.chapterListHolder.scrollList("toCurrent");
};
media.addEventListener("complete", listener);

// move the slider to the correct position on load
media.onLoad = function() {
	this.volume = _root.volumeControl.statusVolume._x;
}