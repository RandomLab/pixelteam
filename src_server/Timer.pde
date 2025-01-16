class Timer{

	int millis = 0;
	int time = 0;
	boolean started = false;
	Runnable callback;

	//-------------------------------------------------------------
	//	CONSTRUCTOR
	//-------------------------------------------------------------
	Timer(){
	}

	//-------------------------------------------------------------
	//	START
	//-------------------------------------------------------------
	void start(int time){
		this.millis = millis();
		this.time = time;
		started = true;
	}

	//-------------------------------------------------------------
	//	RUN
	//-------------------------------------------------------------
	void run(){
		if (isFinished() && callback != null && started) {
			callback.run();
			started = false;
		}
	}

	//-------------------------------------------------------------
	//	IS FINISHED
	//-------------------------------------------------------------
	boolean isFinished(){
		return millis() - this.millis > this.time;
	}

	//-------------------------------------------------------------
	//	GET POURCENTAGE
	//-------------------------------------------------------------
	float getPoucentage(){
		return (millis() - this.millis) * 100 / float(this.time);
	}

	float getRemainingTime (){
		return this.time - (millis() - this.millis);
	}

	//-------------------------------------------------------------
	//	ADD CALLBACK
	//-------------------------------------------------------------
	void addCallback(Runnable callback) {
		this.callback = callback;
	}

}