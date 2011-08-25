package nl.cwi.swat.quanda.data;

import java.util.List;

import nl.cwi.swat.quanda.event.Event;


public abstract class Expression extends Node {
	private Object value;
	
	public Object getValue(int n, List<Event> changes) {
		notify(n, changes);
		return getValue();
	}
	
	protected Object getValue() {
		return value;
	}
	
	@Override
	public void notify(int n, List<Event> changes) {
		if (!outOfDate(n)) {
			return;
		}
		setUpToDate(n);

		Object x = getValue();
		Object y = compute(n, changes);
		if (x == y || (x != null && x.equals(y))) {
			return; // no change
		}
		update(n, y);
		notifyDependents(n, changes);
	}

	@Override
	protected void update(int n, List<Event> changes) {
		update(n, compute(n, changes));
	}
	
	protected void update(int n, Object x) {
		setValue(x);
	}

	protected void setValue(Object x) {
		this.value = x;
	}

	protected abstract Object compute(int n, List<Event> changes);
	
}
