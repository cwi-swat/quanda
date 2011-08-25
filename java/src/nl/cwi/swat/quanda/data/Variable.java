package nl.cwi.swat.quanda.data;

import java.util.List;

import nl.cwi.swat.quanda.event.Event;


public class Variable extends Binding {
	public Variable(String name) {
		super(name);
	}
	
	@Override
	public void notify(int n, List<Event> changes) {
		// bind has been called before.
		if (!outOfDate(n)) {
			return;
		}
		setUpToDate(n);
		notifyDependents(n, changes);
	}

	public void bind(Object x) {
		Object v = getValue();
		if (x == v || (x != null && x.equals(v))) {
			return;
		}
		setValue(x);
	}
	
	@Override
	protected Object compute(int n, List<Event> changes) {
		return getValue(n, changes);
	}

}
