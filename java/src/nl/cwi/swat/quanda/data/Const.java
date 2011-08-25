package nl.cwi.swat.quanda.data;

import java.util.List;

import nl.cwi.swat.quanda.event.Event;

public class Const extends Expression {

	public Const(Object value) {
		setValue(value);
	}
	
	@Override
	public void notify(int n, List<Event> changes) {
		setUpToDate(n);
	}
	
	@Override
	protected Object compute(int n, List<Event> changes) {
		return getValue(n, changes);
	}
	
	

}
