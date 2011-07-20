package nl.cwi.swat.quanda.model;

import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlIDREF;
import javax.xml.bind.annotation.XmlList;
import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement
public class Questionnaire {
	private List<Question> questions;
	private List<Question> initial;
//	private Set<State> states;
//	private State initial;
	
	@XmlElementWrapper(name = "questions")
	@XmlElement(name = "question")
	public List<Question> getQuestions() {
		return questions;
	}
	
	public void setQuestions(List<Question> questions) {
		this.questions = questions;
	}
	
	@XmlElement
	@XmlList
	@XmlIDREF
	public List<Question> getInitial() {
		return initial;
	}
	
	public void setInitial(List<Question> initial) {
		this.initial = initial;
	}

//	@XmlAttribute
//	@XmlIDREF
//	public State getInitial() {
//		return initial;
//	}
//	
//	public void setInitial(State initial) {
//		this.initial = initial;
//	}
//	
//	@XmlElementWrapper(name = "states")
//	@XmlElement(name = "state")
//	public Set<State> getStates() {
//		return states;
//	}
//	
//	public void setStates(Set<State> states) {
//		this.states = states;
//	}
	
	
	
}
