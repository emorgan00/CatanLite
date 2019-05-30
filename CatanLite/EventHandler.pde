Deque<Event> EVENT_STACK = new ArrayDeque<Event>();

void runEvent() {
	// remove inactive Events from the stack
	while (EVENT_STACK.size() > 0 && !EVENT_STACK.getFirst().active) {
		EVENT_STACK.removeFirst();
	}
	// load topmost event
	Event event = EVENT_STACK.peekFirst();
	if (event == null) return;
	// run load() if event is new
	if (event.waiting) {
		event.waiting = false;
		event.load();
	}
	event.tick();
}

void addEvent(Event event) {
	EVENT_STACK.addFirst(event);
}

abstract class Event {

	boolean active, waiting;

	Event() {
		active = true;
		waiting = true;
	}

	String toString() {
		return this.getClass().getCanonicalName();
	}

	// this method will be called by the Event stack when the Event is loaded for the first time
	abstract void load();

	// this method will be called by the Event stack once per draw.
	abstract void tick();

	void close() {
		active = false;
	}

	// send a key press to this event
	void keyPressed() {}

}