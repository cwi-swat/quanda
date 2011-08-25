package nl.cwi.swat.quanda.data;

import java.util.List;

import nl.cwi.swat.quanda.event.Event;

public class Assign extends Binding {
	private Expression exp;

	public Assign(String name, Expression exp) {
		super(name);
		this.exp = exp;
		exp.addDependent(this);
	}
	
	@Override
	protected Object compute(int n, List<Event> changes) {
		return exp.getValue(n, changes);
	}

}
