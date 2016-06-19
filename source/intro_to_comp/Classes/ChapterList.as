dynamic class ChapterList extends MovieClip {
	// starting y position of the chapter list
	var startPositionY:Number = 0;
	// the y position of the last item added
	// used for controling the scroll function
	var lastPositionY:Number = 0;
	// the speed at which the box scrolls (in pixels)
	var scrollSpeed:Number = 5;
	// number of the current slide
	var currentSlideId:Number = 0;
	
	// ---------------------------------------------------------------------
	// CONSTRUCTOR - Loads XML and populates chapter list
	// ---------------------------------------------------------------------
	function ChapterList() {
		// initialize the starting X variable, which should equal 8.65
		this.startPositionY = this._y;
		// create a new XML object
		chapters_xml = new XML();
		// ignore white space that is human reading purposes only
		chapters_xml.ignoreWhite = true;
		// populate the chapter list
		chapters_xml.onLoad = function(success) {
			if (success) {
				for (i=0; i<this.firstChild.childNodes.length; i++) {
					var title:String = this.firstChild.childNodes[i].attributes.title;
					var slideName:String = this.firstChild.childNodes[i].attributes.slideName;
					_root.chapterList.chapterListHolder.populateItem(i, title, slideName);
				}
				// make the first chapter listing selected
				_root.chapterList.chapterListHolder.item0.gotoAndStop("selected");
			}
			// end if
		};
		// end onLoad
		// load chapters.xml
		chapters_xml.load("chapters.xml");
	}
	// end constructor
	
	// ---------------------------------------------------------------------
	// POPULATE ITEM - Creates chapter listing.
	// 		(It's easy to put this in a method than inside onLoad)
	// ---------------------------------------------------------------------
	function populateItem(id:Number, title:String, slideName:String):Void {
		// attach the chapter item movie clip
		this.attachMovie("chapterListItem", "item"+id, this.getDepth()+id);
		// give the item an id
		this["item"+id].id = id;
		// give the item a slide name
		this["item"+id].slideName = slideName;
		// set it's title (you have to embed the fonts to make them show up)
		this["item"+id].titleText = title;
		// move the chapter item to its position
		this["item"+id]._y = this.lastPositionY;
		// increment for the next item (each one is 20 pixels high)
		this.lastPositionY += 20;
		// turn on the scroll button if needed
		if (id>2) {
			_parent.downScroll.gotoAndStop("live");
		}
	}
	// end populateItem

	// ---------------------------------------------------------------------
	// SCROLL LIST - Moves list up or down
	// ---------------------------------------------------------------------
	function scrollList(direction:String):Void {
		// turn the scroll up button on/off
		if (this._y<this.startPositionY) {
			_parent.upScroll.gotoAndStop("live");
			_parent.upScroll.enabled = true;
		} else if (this._y>=this.startPositionY) {
			_parent.upScroll.gotoAndStop("dead");
			_parent.upScroll.enabled = false;
			_parent.upScroll.mousePress = false;
		}
		// turn the scroll down button on/off
		if (this._y>(64-this.lastPositionY)) {
			_parent.downScroll.gotoAndStop("live");
			_parent.downScroll.enabled = true;
		} else if (this._y<=(64-this.lastPositionY)) {
			_parent.downScroll.gotoAndStop("dead");
			_parent.downScroll.enabled = false;
			_parent.downScroll.mousePress = false;
		}
		// move the chapter list up or down
		if ((direction == "up") && (this._y<this.startPositionY)) {
			this._y += this.scrollSpeed;
		} else if ((direction == "down") && (this._y>(64-this.lastPositionY))) {
			this._y -= this.scrollSpeed;
		// or to the currently selected item	
		} else if (direction == "toCurrent") {
			// grab the id of the current slide, multiple it times the height of
			// each item (20), add the current Y of the list holder (which is always less than 8.65)
			currentPositionY = (this["item"+this.currentSlideId].id * 20) + this._y;
			// if the Y of the selected chapter is outside the viewable area, move it until it isn't 
			if (currentPositionY<8.65) {
				while(currentPositionY<8.65) {
					this._y++;
					currentPositionY = (this["item"+this.currentSlideId].id * 20) + this._y;
				}
			}
			if (currentPositionY>44) {
				while(currentPositionY>44) {
					this._y--;
					currentPositionY = (this["item"+this.currentSlideId].id * 20) + this._y;
				}
			}
		}
		// 64 is the height of the chapter list window
	}
	// end scrollList
	
	// ---------------------------------------------------------------------
	// MOVE HIGHLIGHT - Change selected chapter item and update current id
	// ---------------------------------------------------------------------
	function moveHighlight(changeId:Number):Void {
		// change the selected chapter item to normal
		this["item"+this.currentSlideId].gotoAndStop("normal");
		// just bumping up one slide through the 
		this.currentSlideId += changeId;
		// highlight the new chapter item
		this["item"+this.currentSlideId].gotoAndStop("selected");
	}
	// end seekSlide
	
	// ---------------------------------------------------------------------
	// CHAPTER SLIDE ID
	//		- returns currentSlideId for PresentationHolder
	// ---------------------------------------------------------------------
	function get chapterSlideId():Number {
		return this.currentSlideId;
	}
}
// end class
