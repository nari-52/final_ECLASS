package com.spring.common;

public class Common {

	private String firstName;
	private String lastName;
	
	public Common() {	
	}
	
	public Common(String firstName, String lastName) {
		
		if(firstName == null || lastName == null) {
			throw new IllegalArgumentException("firstName and lastName are required.");
		}
		this.firstName = firstName;
		this.lastName = lastName;
	}
	
	public Common(int random) {
		System.out.println("randomValue: " + random);
		this.firstName = random + "";
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	
	//////////////
	
	public static void main(String[] args) {
		String test = "faeea";
		String test2 = new String("sadsas");
		
		Common com = new Common("dasdas", "qe2e");
		
		
		Common com2 = new Common();
		com2.setFirstName("12312");
		com2.setLastName("vdsv");
		
		Common com3 = new Common(1);
		
		Common com4 = new Common(null, null);
		
		
	}
}
