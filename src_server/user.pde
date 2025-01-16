ArrayList<User> users = new ArrayList<User>();
//-------------------------------------------------------------
//	ADD USER
//-------------------------------------------------------------
void addUser(String ip){
	User u = new User(ip);
	users.add(u);
}

boolean isExisting(String ip){
	for (int i = 0; i < users.size(); i++) {
		if (users.get(i).ip.equals(ip)) {
			return true;
		}
	}
	return false;
}

void updateUser(Data d){
	boolean isExisting = false;
	for (int i = 0; i < users.size(); i++) {
		if (users.size()>0 && users.get(i).ip.equals(d.ip)) {
			users.get(i).updateUser(d);
			isExisting = true;
		}
	}
	if (isExisting == false) {
		addUser(d.ip);
	}

}

void runUser(){
	for (int i = 0; i < users.size(); i++) {
		users.get(i).aliveTimer--;
		if (users.get(i).aliveTimer<0) {
			users.remove(i);
		}
	}
}

void drawUser(int dx, int dy){
	if (users.size()>0)
	for (int i = 0; i < users.size(); i++) {
		users.get(i).drawUser(dx,dy);
	}
}

//-------------------------------------------------------------
// User
//-------------------------------------------------------------
class User{
	Data data;
	int aliveTimer = 200;
	String ip;

	User(String ip){
		this.ip = ip;
	}

	void updateUser(Data d){
		aliveTimer = 200;
		data = d;
	}

	void drawUser(int dx, int dy){
		noFill();
		if(data!=null){
			stroke(data.r, data.g, data.b);
			ellipse(dx+data.x, dy+data.y, data.brushSize, data.brushSize);
			fill(data.r, data.g, data.b);
			text(data.name, dx+data.x+data.brushSize/2+4, dy+data.y);
			aliveTimer--;
		}
	}

	void debug_display(int x, int y){
		text("ip : " + data.ip + "  alive : "+aliveTimer, data.x, data.y);
	}

	void sendClear(){
		OscMessage m = new OscMessage("/clear");
		NetAddress ordi = new NetAddress(ip, 12000);
		oscP5.send(m, ordi);
	}
}