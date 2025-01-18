import oscP5.*;
import netP5.*;


ButtonPanel button_panel_brush;
ButtonPanel button_panel_color;

Page page;
int page_size_width;
int page_size_height;

PFont fira_12;

int blocked = 0;
boolean clearPage = false;
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
	//init font
	fira_12 = createFont("firafont/FiraCode-Medium.ttf", 12);
	//init osc
	initOsc();
	//init page
	page = new Page(page_size_width, page_size_height);
	//init interface
	init_interface();
}

void init_interface() {
	int[] bound = page.get_bounds();
	
	// panel brush
	button_panel_brush = new ButtonPanel();
	int[] brushSize = {2,5, 10, 15, 20, 25};
	int x = bound[0] + bound[2] + 5;
	int y = bound[1];
	int w = 30;
	int h = 30;
	for (int i = 0; i < brushSize.length; i++) {
		ButtonCircle b = new ButtonCircle(x, y, w, h, color(220));
		b.value = brushSize[i];
		button_panel_brush.addButton(b);
		y += h + 2;
	}
	
	// panel color
	button_panel_color = new ButtonPanel();
	Color[] colors = loadBank("color_bank_100.txt");
	x = bound[0] - 30 - 5;
	y = bound[1];
	w = 30;
	h = 30;
	int max_width = width - 100;
	
	for (int i = 0; i < colors.length; i++) {
		Button b = new Button(x, y, w, h, colors[i].value);
		b.value = colors[i].value;
		button_panel_color.addButton(b);
		y += h + 2;
		if (y > bound[1] + bound[3] - h) {
			x -= w + 2;
			y = bound[1];
		}
	}
}


//-------------------------------------------------------------
//	DRAW
//-------------------------------------------------------------
void draw() {
	noStroke();
	background(60);
	
	if (blocked > 0) {
		fill(255,0,0);
		rect(0,0,width,height);
	} else{
		button_panel_color.draw();
		button_panel_brush.draw();
		
		if (page.isMouseOver()) {
			if (mousePressed) {
				if (button_panel_brush.getSelected() != null && button_panel_color.getSelected() != null) {
					page.drawPage(
						mouseX - page.get_bounds()[0], 
						mouseY - page.get_bounds()[1], 
						pmouseX - page.get_bounds()[0],
						pmouseY - page.get_bounds()[1],
						button_panel_color.getSelected().value, 
						button_panel_brush.getSelected().value);
				}
			}
		}
		
		color c = button_panel_color.getSelected().value;
		send_message(
			mouseX - page.get_bounds()[0], 
			mouseY - page.get_bounds()[1], 
			pmouseX - page.get_bounds()[0],
			pmouseY - page.get_bounds()[1],
			int(red(c)),int(green(c)),int(blue(c)),
			mousePressed,
			button_panel_brush.getSelected().value,
			"bob"
			);
	}
	
	//compute the draw
	page.displayPage();
	call_server();
	
	//draw debug
	int[] bound = page.get_bounds();
	fill(255);
	textFont(fira_12);
	text("Server IP : " + distantIP, bound[0], bound[1] + bound[3] + 20);
	
	if (blocked > 0) {
		blocked--;
	}
	if (clearPage) {
		page.clear_page();
		clearPage = false;
	}
}

//-------------------------------------------------------------
//	MOUSE PRESSED
//-------------------------------------------------------------
void mousePressed() {
	button_panel_color.onClick();
	button_panel_brush.onClick();
}


