package shey;

import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @Project: Default (Template) Project
 * @File: ${NAME}.java
 * @PACKAGE_NAME: shey
 * @Version: 1.0.0
 * @Author: Shey
 * @Created: 2024-03-24
 * @Modified: 2024-03-24
 * @Description: ${NAME}.java
 **/
public class Main {
    public static void main(String[] args) {
        String str = "String,without,spaces";

        StringTokenizer tokenizer = new StringTokenizer(str, ",");
        String[] words = new String[tokenizer.countTokens()];

        int index = 0;
        while (tokenizer.hasMoreTokens()) {
            words[index] = tokenizer.nextToken();
            index++;
        }

        for (String word : words) {
            System.out.println(word);
        }
    }
}