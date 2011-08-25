package nl.cwi.swat.quanda.state;

import java.util.List;

import nl.cwi.swat.quanda.model.Group;

public class Nest extends State {
	
	private List<State> children;
	
	public Nest(Group group) {
		super(group);
	}

	public List<State> getChildren() {
		return children;
	}
	
	
	
}
