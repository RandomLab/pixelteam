class Button{
	int x, y, w, h;
	color color_back = color(255);
	boolean selected = false;
	Runnable callback; // Callback function
	int value;
	
	Button(int x,int  y,int  w,int h,color color_back){
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		this.color_back = color_back;
	}
	
	void draw() {
		fill(color_back);
		noStroke();
		rectMode(CORNER);
		rect(this.x, this.y, this.w, this.h);
		
		noFill();
		if (selected) {
			stroke(255);
		} else{
			stroke(0);
			noStroke();
		}
		strokeWeight(2);
		rectMode(CORNER);
		rect(this.x, this.y, this.w, this.h);
	}

	void addCallback(Runnable callback) {
		this.callback = callback;
	}
	
	boolean isMouseOver() {
		return mouseX > this.x && mouseX < this.x + this.w && mouseY > this.y && mouseY < this.y + this.h;
	}
	
	void onClick() {
    // Trigger the callback if the button is clicked
    if (isMouseOver() && mousePressed && callback != null) {
      callback.run();
    }
  }
	
}