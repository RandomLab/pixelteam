//-------------------------------------------------------------
// Page
//-------------------------------------------------------------
class Page{
	PGraphics pg;
	int page_number = 0;

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
	void drawPage() {
		pg.beginDraw();
		if (datas.size()>0) {
			for (int i = 0; i < datas.size(); i++) {
				if (datas.get(i)!= null && datas.get(i).isPressed) {
					datas.get(i).draw(pg);
				}
				updateUser(datas.get(i));
			}
		}
		datas.clear();
		pg.endDraw();
	}

	int [] get_bounds() {
		int x = width/2 - pg.width/2;
		int y = height/2 - pg.height/2;
		int w = pg.width;
		int h = pg.height;
		return new int[] {x,y,w,h};
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
	
	//-------------------------------------------------------------
	// Save page
	//-------------------------------------------------------------
	void savePage() {
		save("pages/image_" + getTimestampWithUnderscores() + ".png");
		pg.beginDraw();
		pg.background(255);
		pg.endDraw();
		page_number++;
		brushSize = int(random(10,15));
	}

	//-------------------------------------------------------------
	// Clear page
	//-------------------------------------------------------------
	void clear_page() {
		pg.beginDraw();
		pg.background(255);
		pg.endDraw();
	}
}