package nl.cwi.swat.quanda.data;

import java.util.List;

import nl.cwi.swat.quanda.event.Event;
import nl.cwi.swat.quanda.event.Update;

public class Output implements Notifiable {

	private final Expression exp;
	
	public Output(Expression exp) {
		this.exp = exp;
		exp.addDependent(this);
	}
	
	@Override
	public void notify(int n, List<Event> changes) {
		Object x = exp.getValue(n, changes);
		changes.add(new Update(this, x));
	}

}
