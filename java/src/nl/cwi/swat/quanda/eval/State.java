package nl.cwi.swat.quanda.eval;

import java.util.HashSet;
import java.util.Set;

import nl.cwi.swat.quanda.model.Question;

public class State {

	private final Set<Question> enabled;
	private final Set<Question> answered;
	
	public State() {
		this(new HashSet<Question>(), new HashSet<Question>());
	}
	
	private State(Set<Question> enabled, Set<Question> answered) {
		this.enabled = enabled;
		this.answered = answered;
	}
		
	public State next(Question q) {
		return new State(new HashSet<Question>(enabled), new HashSet<Question>(answered));
	}
		
	
}
