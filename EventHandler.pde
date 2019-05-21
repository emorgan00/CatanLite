Deque<Event> EVENT_STACK = new ArrayDeque<Event>();
Event CURRENT_EVENT;

void runEvent() {
	if (CURRENT_EVENT != null) {
		if (CURRENT_EVENT.waiting) {
			CURRENT_EVENT.waiting = false;
			CURRENT_EVENT.load();
		}
		CURRENT_EVENT.tick();
		if (!CURRENT_EVENT.active) {
			CURRENT_EVENT = null;
		}
	}
	if (CURRENT_EVENT == null && EVENT_STACK.size() > 0) {
		CURRENT_EVENT = EVENT_STACK.removeFirst();
	}
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

	// this method will be called by the Event stack when the Event is loaded for the first time
	abstract void load();

	// this method will be called by the Event stack once per draw.
	abstract void tick();

	void close() {
		active = false;
	}

}