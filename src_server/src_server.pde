import oscP5.*;
import netP5.*;

Page page;
PFont fira;
PFont fira_12;
Timer timer;

//timer
int timerTime = 1000*60*3;

//object osc > un serveur
int page_size_width;
int page_size_height;

int brushSize = 5;
boolean save_lock = false;

//-------------------------------------------------------------
//	SETTINGS
//-------------------------------------------------------------
void settings() {
	//float r = 3.4;
	float r = 3.0;
	
	page_size_width = int(210 * r * 2);
	page_size_height = int(297 * r);
	
	println("--------------------------------------------------------------");
	println("page size : " + page_size_width + " " + page_size_height);
	println("--------------------------------------------------------------");
	
	//fullScreen(P2D);
	size(1920, 1080,P2D);
}

//-------------------------------------------------------------
//	SETUP
//-------------------------------------------------------------
void setup() {
	fira = createFont("firafont/FiraCode-Medium.ttf", 20);
	fira_12 = createFont("firafont/FiraCode-Medium.ttf", 12);
	//init osc
	initOsc();
	//init page
	page = new Page(page_size_width, page_size_height);

	brushSize = int(random(10,15));
	timer = new Timer();
	timer.start(timerTime);
	timer.addCallback(() -> saveAndRefresh());
}

//-------------------------------------------------------------
//	DRAW
//-------------------------------------------------------------
void draw() {
	noStroke();
	background(60);
	
	textFont(fira);

	//compute the draw
	page.drawPage();
	page.displayPage();
	
	if (save_lock) {
		page.savePage();
		save_lock = false;
	}

	int[] b = page.get_bounds();
	drawUser(b[0],b[1]);

	//debug
	rectMode(CORNER);
	fill(0);
	stroke(255);
	strokeWeight(1);
	int x = b[0];
	int y = b[1]-40;
	int w = b[2];
	int h = 20;
	rect(x,y,w,h);

	noStroke();
	fill(255);

	float wf = map(
		timer.getPoucentage(),
		0,
		100,
		0,
		b[2]
	);
	rect(x,y,wf,h);

	text("next clear in " + int(timer.getRemainingTime()/1000)+" seconds",x,y-5);

	timer.run();
	debug();
}
//-------------------------------------------------------------
//	DEBUG
//-------------------------------------------------------------
void debug() {
	int x = 20;
	int y = 100;
	rectMode(CORNER);
	fill(0);
	noStroke();
	rect(x-3,y-16,200,200);

	fill(255);
	textFont(fira_12);
	text("datas size : " + datas.size(),x,y);
}

void saveAndRefresh() {
	save_lock = true;
	timer.start(timerTime);
}

void keyPressed() {
	if (key ==  'c') {
		page.clear_page();
	}
}


