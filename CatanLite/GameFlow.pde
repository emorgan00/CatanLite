class TurnLoopEvent extends Event {
	
	void load() {}
	
	void tick() {
		for (int x = PLAYERS.size()-1; x >= 0; x--) {
			addEvent(new TurnEvent(PLAYERS.get(x)));
			if (x == 0) addEvent(new SwitchPlayerEvent(PLAYERS.get(PLAYERS.size()-1), PLAYERS.get((x))));
			else addEvent(new SwitchPlayerEvent(PLAYERS.get(x-1), PLAYERS.get((x))));
		}
	}
}

class DelayEvent extends Event {

	long timer;

	DelayEvent(long millis) {
		timer = millis;
	}

	void load() {}

	void tick() {
		if (timer < 0) close();
		timer -= DT;
	}
}

class SwitchPlayerEvent extends Event {

	Player prev, next;
	float miny;
	long timer;

	static final long maxtimer = 400;

	SwitchPlayerEvent(Player prev, Player next) {
		this.prev = prev;
		this.next = next;
	}

	void load() {
		miny = next.contents.y;
		next.contents.y = height;
		next.contents.active = true;
		timer = maxtimer;
	}

	void tick() {
		next.contents.y = miny+(height-miny)*((float)timer/maxtimer);
		prev.contents.y = miny+(height-miny)*(1-(float)timer/maxtimer);
		if (timer < 0) {
			prev.contents.y = miny;
			next.contents.y = miny;
			prev.contents.active = false;
			refreshHighlights(next);
			close();
		}
		timer -= DT;
	}

}