dynamic class PresentationHolder extends MovieClip {
	// ---------------------------------------------------------------------
	// CONSTRUCTOR
	//		- loads the presentation
	//		- sets up the loading management of it
	// ---------------------------------------------------------------------
	function PresentationHolder() {
		// attach the presentation opener to be replaced by the loaded clip
		this.attachMovie("presentationOpener", "placeHolder", this.getDepth()+1);
		// load the presentation into the player
		this.placeHolder.loadMovie("Presentation.swf");
		// manage the loading process
		_global.loadManage = setInterval(managePresentationLoad, 75);
	}
	// end constructor
	
	// ---------------------------------------------------------------------
	// MANAGE PRESENTATION LOAD
	// 		- updates the presentation load process every 75 ms
	//		- once loaded, this dies (much better than onEnterFrame)
	// ---------------------------------------------------------------------
	function managePresentationLoad():Void {
		// can't use "this." to grab these variables for some reason
		loaded = _root.presentationHolder.placeHolder.getBytesLoaded();
		total = _root.presentationHolder.placeHolder.getBytesTotal();
		if (loaded != total) {
			_root.mediaProgressBar.updateBuffer((loaded/total)*269);
			_root.mediaProgressBar.updateMessage("Loading Presentation");
		} else {
			_root.mediaProgressBar.updateBuffer(269);
			_root.mediaProgressBar.updateMessage("Presentation Loaded");
			clearInterval(_global.loadManage);
		}
	}
	// end managePresentationLoad
	
	// ---------------------------------------------------------------------
	// SEEK SLIDE - Change selected chapter item and update current id
	// ---------------------------------------------------------------------
	function skipSlides(gotoSlideId:Number):Void {
		currentSlideId = _root.chapterList.chapterListHolder.chapterSlideId;
		// because gotoSlide does not work, we have to manually do it
		if (currentSlideId<gotoSlideId) {
			while (currentSlideId != gotoSlideId) {
				this.placeHolder.presentation.currentSlide.gotoNextSlide();
				_root.chapterList.chapterListHolder.moveHighlight(1);
				currentSlideId = _root.chapterList.chapterListHolder.chapterSlideId;
			}
		} else if (currentSlideId>gotoSlideId) {
			while (currentSlideId != gotoSlideId) {
				this.placeHolder.presentation.currentSlide.gotoPreviousSlide();
				_root.chapterList.chapterListHolder.moveHighlight(-1);
				currentSlideId = _root.chapterList.chapterListHolder.chapterSlideId;
			}
		}
	}
	// end skipSlides
}
// end class
