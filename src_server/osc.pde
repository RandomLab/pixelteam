//===================================================================
//	RECEIVE OSC DATA
//===================================================================
//list of received data
OscP5 oscP5;
ArrayList<Data> datas = new ArrayList<Data>();

//-------------------------------------------------------------
//	SETUP OSC
//-------------------------------------------------------------
void initOsc() {
	oscP5 = new OscP5(this, 12001);
}

//-------------------------------------------------------------
//	OSC EVENT FOR RECEIVING DATA
//-------------------------------------------------------------
void oscEvent(OscMessage m) {
	//print("### received an osc message." + millis());
	//print(" addrpattern: " + m.addrPattern());
	//println(" typetag: " + m.typetag());
	
	if (m.checkAddrPattern("/p") && m.checkTypetag("iiiiiiiFis") || m.checkTypetag("iiiiiiiTis")) {
		//println("p received");
		//position x, y, previous x, previous y
		int x = m.get(0).intValue();
		int y = m.get(1).intValue();
		//println("x : " + x + " y : " + y);
		int px = m.get(2).intValue();
		int py = m.get(3).intValue();
		//color r, g, b
		int r = m.get(4).intValue();
		int g = m.get(5).intValue();
		int b = m.get(6).intValue();
		//others datas
		boolean isPressed = false;
		if (m.checkTypetag("iiiiiiiFis")) {
			isPressed = false;
		} else{
			isPressed = true;
		}
		int brushSize = m.get(8).intValue();
		String name = m.get(9).stringValue();
		String ip = m.netAddress().address();
		//add data
		Data d = new Data(x, y, px, py, r, g, b, isPressed, brushSize, name,ip);
		datas.add(d);
	}
	if (m.checkAddrPattern("/call")) {
		//println("call received");
		String ip = m.netAddress().address();
		OscMessage m2 = new OscMessage("/server");
		NetAddress ordi = new NetAddress(ip, 12000);
		oscP5.send(m2, ordi);
	}
}

class Data {
	int x, y, px, py, r, g, b;
	boolean isPressed = false;
	int brushSize = 5;
	String name = "";
	String ip = "";
	
	Data(int x, int y, int px, int py, int r, int g, int b,boolean isPressed, int brushSize, String name,String ip) {
		this.x = x;
		this.y = y;
		this.px = px;
		this.py = py;
		this.r = r;
		this.g = g;
		this.b = b;
		this.isPressed = isPressed;
		this.brushSize = brushSize;
		this.name = name;
		this.ip = ip;
	}
	
	void draw(PGraphics pg) {
		if (isPressed) {
			//pg.fill(r, g, b);
			//pg.noStroke();
			//pg.ellipse(x, y, brushSize, brushSize);
			pg.stroke(r, g, b);
			pg.strokeWeight(brushSize);
			pg.line(x, y, px, py);
		}
	}
}