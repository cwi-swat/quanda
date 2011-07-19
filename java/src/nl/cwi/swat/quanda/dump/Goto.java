package nl.cwi.swat.quanda.dump;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlIDREF;
import javax.xml.bind.annotation.XmlList;

public class Goto {
	private List<Question> guards;
	private State target;
	
	@XmlAttribute
	@XmlList
	@XmlIDREF
	public List<Question> getGuards() {
		return guards;
	}
	
	public void setGuards(List<Question> guards) {
		this.guards = guards;
	}
	
	@XmlAttribute
	@XmlIDREF
	public State getTarget() {
		return target;
	}
	
	public void setTarget(State target) {
		this.target = target;
	}
	
	@Override
	public String toString() {
		Set<String> qids = new HashSet<String>();
		for (Question q: getGuards()) {
			qids.add(q.getId());
		}
		return "if " + qids + " then " + getTarget().getId();
	}
}
