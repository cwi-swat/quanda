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

}
