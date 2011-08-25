package nl.cwi.swat.quanda.data;

import java.util.List;

import nl.cwi.swat.quanda.event.Event;

public class Add extends Expression {

	public final Expression lhs, rhs;
	
	public Add(Expression lhs, Expression rhs) {
		this.lhs = lhs;
		this.rhs = rhs;
		lhs.addDependent(this);
		rhs.addDependent(this);
	}
	
	@Override
	protected Object compute(int n, List<Event> changes) {
		Integer a = (Integer)lhs.getValue(n, changes);
		Integer b = (Integer)rhs.getValue(n, changes);
		if (a == null || b == null) {
			return null;
		}
		return a + b;
	}
	
	

}
