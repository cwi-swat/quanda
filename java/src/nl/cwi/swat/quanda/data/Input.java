package nl.cwi.swat.quanda.data;

import java.util.List;

import nl.cwi.swat.quanda.event.Enable;
import nl.cwi.swat.quanda.event.Event;
import nl.cwi.swat.quanda.event.Update;
import nl.cwi.swat.quanda.event.Updateable;

public class Input implements Notifiable, Updateable {

	private Variable var;
	private Expression cond;
	
	public Input(String name, Expression cond) {
		this(new Variable(name), cond);
	}
	
	public Input(Variable var, Expression cond) {
		this.var = var;
		this.cond = cond;
		cond.addDependent(this);
	}

	/*
	 * An input is notified if its condition changes.
	 */
	@Override
	public void notify(int n, List<Event> changes) {
		Object c = cond.getValue(n, changes);
		changes.add(new Enable(getName(), c != null && c.equals(true)));
	}

	private String getName() {
		return var.getName();
	}

	@Override
	public void acceptEvent(Event event) {
		// TODO: refactor to double dispatch
		if (event instanceof Update) {
			Update upd = (Update)event;
			if (upd.getName().equals(getName())) {
				var.bind(upd.getValue());
			}
		}
	}

	
}
