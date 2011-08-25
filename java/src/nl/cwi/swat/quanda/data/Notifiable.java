package nl.cwi.swat.quanda.data;

import java.util.List;

import nl.cwi.swat.quanda.event.Event;


public interface Notifiable {
	public void notify(int n, List<Event> changes);
}
