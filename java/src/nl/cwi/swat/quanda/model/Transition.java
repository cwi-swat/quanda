package nl.cwi.swat.quanda.model;

import java.util.List;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlIDREF;


public class Transition {

	private Question answered;
	private List<Goto> gotos;

	@XmlAttribute
	@XmlIDREF
	public Question getAnswered() {
		return answered;
	}
	
	public void setAnswered(Question answered) {
		this.answered = answered;
	}
	
	@XmlElement(name = "goto")
	public List<Goto> getGotos() {
		return gotos;
	}
	
	public void setGotos(List<Goto> gotos) {
		this.gotos = gotos;
	}
	
	@Override
	public String toString() {
		return "on " + getAnswered().getId() + ": " + gotos;
	}
}
