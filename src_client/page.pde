//-------------------------------------------------------------
// Page
//-------------------------------------------------------------
class Page{
	PGraphics pg;
	
	//-------------------------------------------------------------
	// Constructor
	//-------------------------------------------------------------
	Page(int w,int h) {
		pg = createGraphics(w, h, P2D);
		pg.beginDraw();
		pg.background(220);
		pg.endDraw();
	}
	
	//-------------------------------------------------------------
	// Draw page
	//-------------------------------------------------------------
	void drawPage(int x,int y,color c,int size) { 
		pg.beginDraw();
		pg.fill(c);
		pg.noStroke();
		pg.ellipse(x, y, size, size);
		pg.endDraw();
	}

	void drawPage(int x1,int y1,int x2,int y2,color c,int size) { 
		pg.beginDraw();
		pg.stroke(c);
		pg.strokeWeight(size);
		pg.line(x1, y1, x2, y2);
		pg.endDraw();
	}

	//-------------------------------------------------------------
	// Display page
	//-------------------------------------------------------------
	void displayPage() {
		rectMode(CENTER);
		fill(255);
		stroke(0);
		strokeWeight(5);
		rect(width/2, height/2, pg.width, pg.height);
		
		imageMode(CORNER);
		image(pg, width/2 - pg.width/2, height/2 - pg.height/2);
	}

	int [] get_bounds() {
		int x = width/2 - pg.width/2;
		int y = height/2 - pg.height/2;
		int w = pg.width;
		int h = pg.height;
		return new int[] {x,y,w,h};
	}

	boolean isMouseOver() {
		int [] bound = get_bounds();
		return mouseX > bound[0] && mouseX < bound[0] + bound[2] && mouseY > bound[1] && mouseY < bound[1] + bound[3];
	}

	//-------------------------------------------------------------
	// Clear page
	//-------------------------------------------------------------
	void clear_page() {
		pg.beginDraw();
		pg.background(200);
		pg.endDraw();
	}
}