package nl.cwi.swat.quanda.model;

import java.util.List;

import javax.xml.bind.annotation.XmlAttribute;

import com.sun.xml.internal.txw2.annotation.XmlElement;

public class Repeat extends Question {


	private String count;
	private List<Question> questions;


	@XmlElement
	private List<Question> getQuestions() {
		return questions;
	}

	public void setQuestions(List<Question> questions) {
		this.questions = questions;
	}

	@XmlAttribute
	private String getCount() {
		return count;
	}
	
	public void setCount(String count) {
		this.count = count;
	}
	
}
