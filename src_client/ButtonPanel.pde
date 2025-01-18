class ButtonPanel{
	
	ArrayList<Button> buttons = new ArrayList<Button>();
	Button selected_button;
	Runnable callback;
	
	//-------------------------------------------------------------
	//	CONSTRUCTOR
	//-------------------------------------------------------------
	ButtonPanel() {
		
	}
	//-------------------------------------------------------------
	//	ADD BUTTON
	//-------------------------------------------------------------
	void addButton(Button b) {
		buttons.add(b);
		b.addCallback(new Runnable() {
			public void run() {
				//send_message();
				println("Button clicked");
				println(b);
				received_callback(b);
			}
		});
		selected_button = b;
	}
	//-------------------------------------------------------------
	// 	GET SELECTED BUTTON
	//-------------------------------------------------------------
	Button getSelected() {
		return selected_button;
	}

	//-------------------------------------------------------------
	//	RECEIVED CALLBACK
	//-------------------------------------------------------------
	void received_callback(Button b) {
		println("received_callback");
		selected_button = b;
		
		for (int i = 0; i < buttons.size(); i++) {
			buttons.get(i).selected = false;
		}
		selected_button.selected = true;
		
		if (callback != null) {
			callback.run();
		}
	}
	//-------------------------------------------------------------
	//	ADD CALLBACK
	//-------------------------------------------------------------
	void addCallback(Runnable callback) {
		this.callback = callback;
	}
	//-------------------------------------------------------------
	//	DRAW
	//-------------------------------------------------------------
	void draw() {
		for (int i = 0; i < buttons.size(); i++) {
			buttons.get(i).draw();
		}
	}
	//-------------------------------------------------------------
	//	MOUSE PRESSED
	//-------------------------------------------------------------
	void onClick() {
		for (int i = 0; i < buttons.size(); i++) {
			buttons.get(i).onClick();
		}
	}
	
	
}