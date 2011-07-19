package nl.cwi.swat.quanda.dump;

import java.util.List;
import java.util.Set;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement
public class Questionnaire {
	private List<Question> questions;
	private Set<State> states;
	
	@XmlElementWrapper(name = "questions")
	@XmlElement(name = "question")
	public List<Question> getQuestions() {
		return questions;
	}
	
	public void setQuestions(List<Question> questions) {
		this.questions = questions;
	}
	
	
	@XmlElementWrapper(name = "states")
	@XmlElement(name = "state")
	public Set<State> getStates() {
		return states;
	}
	
	public void setStates(Set<State> states) {
		this.states = states;
	}
	
	
	
}
