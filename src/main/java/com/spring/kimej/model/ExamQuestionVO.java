package com.spring.kimej.model;

public class ExamQuestionVO {

	private String question_seq;
	private String exam_seq;
	private String question;
	private String answer;
	
	public ExamQuestionVO() {}
	
	public ExamQuestionVO(String question_seq, String exam_seq, String question, String answer) {
		super();
		this.question_seq = question_seq;
		this.exam_seq = exam_seq;
		this.question = question;
		this.answer = answer;
	}

	public String getQuestion_seq() {
		return question_seq;
	}

	public void setQuestion_seq(String question_seq) {
		this.question_seq = question_seq;
	}

	public String getExam_seq() {
		return exam_seq;
	}

	public void setExam_seq(String exam_seq) {
		this.exam_seq = exam_seq;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}
	
	
	
}
