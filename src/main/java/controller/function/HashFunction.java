package controller.function;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class HashFunction {

   
    public static String generateTokenFromId(int id) {
        return generateToken("id-" + id);
    }
       
    public static String generateToken(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-512");
            byte[] digest = md.digest(input.getBytes());

            // Converti i byte in una stringa esadecimale
            StringBuilder sb = new StringBuilder();
            for (byte b : digest) {
                sb.append(String.format("%02x", b));
            }

            return sb.toString(); // 128 caratteri esadecimali
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-512 non disponibile", e);
        }
    }
   
}
