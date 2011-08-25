package nl.cwi.swat.quanda.data;

import java.util.List;

import nl.cwi.swat.quanda.event.Event;
import nl.cwi.swat.quanda.event.Update;

public class Output implements Notifiable {

	private final Expression exp;
	private final String name;
	
	public Output(String name, Expression exp) {
		this.name = name;
		this.exp = exp;
		exp.addDependent(this);
	}
	
	/*
	 * An output is notified if its expression changes.
	 */
	
	@Override
	public void notify(int n, List<Event> changes) {
		Object x = exp.getValue(n, changes);
		changes.add(new Update(name, x));
	}

}
