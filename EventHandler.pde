Deque<Event> EVENT_STACK = new ArrayDeque<Event>();
Event CURRENT_EVENT;

void runEvent() {
	if (CURRENT_EVENT != null) {
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

	boolean active;

	Event() {
		active = true;
	}

	// this method will be called by the Event queue once per draw.
	abstract void tick();

	void close() {
		active = false;
	}

}