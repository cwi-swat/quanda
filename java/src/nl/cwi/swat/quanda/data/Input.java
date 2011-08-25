package nl.cwi.swat.quanda.data;

import java.util.List;

import nl.cwi.swat.quanda.event.Enable;
import nl.cwi.swat.quanda.event.Event;

public class Input implements Notifiable {

	private Variable var;
	private Expression cond;
	
	public Input(Variable var, Expression cond) {
		this.var = var;
		this.cond = cond;
		cond.addDependent(this);
	}

	@Override
	public void notify(int n, List<Event> changes) {
		Object c = cond.getValue(n, changes);
		changes.add(new Enable(c != null && c.equals(true)));
	}

	
}
