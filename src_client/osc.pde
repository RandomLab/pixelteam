//===================================================================
//	RECEIVE OSC DATA
//===================================================================
//list of received data
OscP5 oscP5;
String localIP = "";
String distantIP = "";

//-------------------------------------------------------------
//	SETUP OSC
//-------------------------------------------------------------
void initOsc() {
	oscP5 = new OscP5(this, 12000);
	localIP = getLocalIP();
	println("--------------------");
	println("local IP : " + localIP);
	println("--------------------");
}

//-------------------------------------------------------------
// SEND MESSAGE
//-------------------------------------------------------------
void send_message(
	int x, int y, 
	int px, int py, 
	int r, int g, int b, 
	boolean isPressed, int brushSize, String name) {
	
	if (distantIP.equals("") ==  false) {
		OscMessage m = new OscMessage("/p");
		m.add(x);
		m.add(y);
		m.add(px);
		m.add(py);
		m.add(r);
		m.add(g);
		m.add(b);
		m.add(isPressed);
		m.add(brushSize);
		m.add(name);
		
		NetAddress ordi = new NetAddress(distantIP, 12001);
		oscP5.send(m, ordi);
	}
}

void oscEvent(OscMessage m) {
	if (m.checkAddrPattern("/server")) {
		distantIP = m.netAddress().address();
		println("distant IP : " + distantIP);
	}
	if (m.checkAddrPattern("/clear") && blocked == 0) {
		blocked = 60*2;
		clearPage = true;
	}
}

//-------------------------------------------------------------
//	call server
//-------------------------------------------------------------
int numberOfCalls = 30*60*3;
void call_server() {
	if (numberOfCalls > 0 && frameCount % 30 == 0) {
		OscMessage m = new OscMessage("/call");
		String ip_broadcast = localIP.substring(0, localIP.lastIndexOf(".")) + ".255";
		NetAddress broadcast = new NetAddress(ip_broadcast, 12001);
		oscP5.send(m, broadcast);
		numberOfCalls--;
		println("call server : " + ip_broadcast + " / " + numberOfCalls);
	}
}