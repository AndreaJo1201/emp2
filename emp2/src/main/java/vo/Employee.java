package vo;

// 캡슐화 단계 : 1. public(100% open) -> 2. protected(같은 패키지와 상속관계만 사용 오픈) -> 3. default(같은 패키지내에서만 사용) -> 4. private(this<나 자신만> 사용 오픈)
// protected / default 단계의 캡슐화는 입문자에게 사용하지 않는다.

public class Employee {
	
	/*
	// 캡슐화하지 않은 날것의 상태
	public int empNo;
	public String firstName;
	public String gender;
	public String hireDate;
	
	//private -> 정보은닉
	private String birthDate;
	
	// 캡슐화(읽기)
	public String getBirthDate() {
		return this.birthDate;
	}
	// 캡슐화(쓰기)
	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}
	*/
	
	private int empNo;
	private String birthDate;
	private String gender;
	private String hireDate;
	private String firstName;
	private String lastName;
	private String name;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public int getEmpNo() {
		return empNo;
	}
	public void setEmpNo(int empNo) {
		this.empNo = empNo;
	}
	public String getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getHireDate() {
		return hireDate;
	}
	public void setHireDate(String hireDate) {
		this.hireDate = hireDate;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	
	
}
