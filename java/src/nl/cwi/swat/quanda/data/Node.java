package nl.cwi.swat.quanda.data;

import java.util.ArrayList;
import java.util.List;

import nl.cwi.swat.quanda.event.Event;

public abstract class Node implements Notifiable {
	private int stamp = -1;
	
	private List<Notifiable> dependents = new ArrayList<Notifiable>();

	public void addDependent(Notifiable e) {
		dependents.add(e);
	}
	
	public List<Notifiable> getDependents() {
		return dependents;
	}

	@Override
	public void notify(int n, List<Event> changes) {
		if (outOfDate(n)) {
			update(n, changes);
			setUpToDate(n);
			notifyDependents(n, changes);
		}
	}

	protected void setUpToDate(int n) {
		stamp = n;
	}
	
	protected void notifyDependents(int n, List<Event> changes) {
		for (Notifiable e: dependents) {
			e.notify(n, changes);
		}
	}

	protected boolean outOfDate(int n) {
		return stamp != n;
	}
	
	protected abstract void update(int n, List<Event> changes);
	
}
