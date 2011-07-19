package nl.cwi.swat.quanda.dump;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlID;
import javax.xml.bind.annotation.XmlIDREF;
import javax.xml.bind.annotation.XmlList;

public class State {

	private Set<Question> enabled;
	private Set<Question> answered;
	private List<Transition> transitions;

	
	private String id;
	
	@XmlAttribute @XmlID
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	@XmlIDREF
	@XmlElement
	@XmlList
	public Set<Question> getEnabled() {
		return enabled;
	}
	
	public void setEnabled(Set<Question> enabled) {
		this.enabled = enabled;
	}
	
	@XmlIDREF
	@XmlElement
	@XmlList
	public Set<Question> getAnswered() {
		return answered;
	}
	
	public void setAnswered(Set<Question> answered) {
		this.answered = answered;
	}
	
	
	@XmlElementWrapper(name = "transitions")
	@XmlElement(name = "on")
	public List<Transition> getTransitions() {
		return transitions;
	}
	
	public void setTransitions(List<Transition> transitions) {
		this.transitions = transitions;
	}
	
	@Override
	public String toString() {
		List<String> eids = new ArrayList<String>(), aids = new ArrayList<String>();
		for (Question q: getEnabled()) {
			eids.add(q.getId());
		}
		for (Question q: getAnswered()) {
			aids.add(q.getId());
		}
		return "<" + eids + ", " + aids + ">";
	}
}
