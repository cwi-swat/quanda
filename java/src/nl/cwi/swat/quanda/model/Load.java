package nl.cwi.swat.quanda.model;

import java.io.FileNotFoundException;
import java.io.FileReader;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;

public class Load {

	public static void main(String[] args) throws FileNotFoundException, JAXBException {
		String packageName = Questionnaire.class.getPackage().getName();
		JAXBContext jc = JAXBContext.newInstance(packageName);
		Unmarshaller u = jc.createUnmarshaller();
		FileReader f = new FileReader("resources/example.xml");
		Questionnaire doc = (Questionnaire)u.unmarshal(f);
		System.out.println(doc);
		
		
		for (Question q: doc.getQuestions()) {
			System.out.println(q);
		}
		
		for (State s: doc.getStates()) {
			System.out.println(s);
			for (Transition t: s.getTransitions()) {
				System.out.println(t);
			}
		}

		System.out.println(doc.getInitial());
	}

}
