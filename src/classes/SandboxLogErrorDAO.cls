/** This is the class to log error messages  in the Sandbox Errors Object */
public with sharing class SandboxLogErrorDAO {

	List<LogError> logList = new List<LogError>();
	public SandboxLogErrorDAO() {


	}

	/** This method inserts errors **/
	public void addErrors(String exceptionDetails, String className,
												String methodName, String sandboxName,
												String sandboxID) {
		logList.add(new LogError(exceptionDetails, className,
								methodName, sandboxName, sandboxID));
	}

	/*public void insertErrors(){
		insert logList;
	}*/

	// This class will record the errors
	class LogError {
		String exceptionDetails {get;set;}
		String className {get;set;}
		String methodName {get;set;}
		String sandboxName {get;set;}
		String sandboxID {get;set;}

		LogError(String exceptionDetails, String className, String methodName,
							String sandboxName, String sandboxID){
			this.exceptionDetails = exceptionDetails;
			this.className = className;
			this.methodName = methodName;
			this.sandboxName = sandboxName;
			this.sandboxID = sandboxID;
		}
	}
}