package nl.cwi.swat.quanda.data;

import java.util.ArrayList;
import java.util.List;

public abstract class Notifiable {
	private int stamp = -1;
	
	private List<Notifiable> dependents = new ArrayList<Notifiable>();

	public void addDep(Notifiable e) {
		dependents.add(e);
	}

	public void notify(int n) {
		if (outOfDate(n)) {
			update(n);
			setUpToDate(n);
			notifyDeps(n);
		}
	}

	protected void setUpToDate(int n) {
		stamp = n;
	}
	
	protected void notifyDeps(int n) {
		for (Notifiable e: dependents) {
			e.notify(n);
		}
	}

	private boolean outOfDate(int n) {
		return stamp != n;
	}
	
	protected abstract void update(int n);
	
}
