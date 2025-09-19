package utilities;
import org.mindrot.jbcrypt.BCrypt;

public class Utils {

	
	public static String HashPass(String pass) {
		
		String hashed = BCrypt.hashpw(pass, BCrypt.gensalt());
		
		return hashed;
	}
	
	public static Boolean checkHash(String EnteredPass, String storedHash) {
		if (BCrypt.checkpw(EnteredPass, storedHash)) {
            return true;
        }
		return false;
	}
	
}
