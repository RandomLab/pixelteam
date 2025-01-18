class ButtonCircle extends Button{
	//-------------------------------------------------------------
	//	Simple extended class for a pen size
	//-------------------------------------------------------------
	ButtonCircle(int x,int  y,int  w,int h,color color_back){
		super(x, y, w, h, color_back);
	}
	void draw() {
		super.draw();
		fill(0);
		ellipse(
			this.x + this.w / 2, this.y + this.h / 2, 
			this.value, this.value
			);
	}
}