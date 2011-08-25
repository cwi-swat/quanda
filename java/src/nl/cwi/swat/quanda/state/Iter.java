package nl.cwi.swat.quanda.state;

import java.util.ArrayList;
import java.util.List;

import nl.cwi.swat.quanda.model.Repeat;

public class Iter extends State {

	private State arg;
	private List<State> children;
	
	public Iter(Repeat question) {
		super(question);
		this.children = new ArrayList<State>();
	}
	
	public List<State> getChildren() {
		return children;
	}
	
	
}
