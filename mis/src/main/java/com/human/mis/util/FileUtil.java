package com.human.mis.util;

import java.io.*;

/**
 * 이 클래스는 파일 업로드에 필요한 기능을 처리하기 위한 클래스
 * @author	김한민
 * @since	2024.04.05
 * @version v.1.0
 * 			
 * 			2024.04.05 - 클래스 제작 [ 담당자 : 김한민 ]
 *
 */
public class FileUtil {
	/*
		파일이 업로드 될때 서버에서 지정한 하나의 폴더에 저장된다.
		이때 파일 이름이 중복되면 겹쳐쓰기가 되고
		기존 파일은 사라지게 된다.
		따라서 동일한 이름의 파일이 존재하면 
		파일의 이름을 변경해서 저장할 필요가 생긴다.
		
		동일한 이름의 파일이 존재하면 업로드하는 파일의 이름을 바꿔주는 함수를 제작하자.
	 */
	public String rename(String path, String oldname) {
		/*
			혹시 
			같은 이름의 파일이 존재하면 (1) 의 방식으로 이름을 바꿔서 저장하는 방식을 사용하자.
		 */
		int cnt = 0; // 같은 이름의 파일 뒤에 붙여질 번호를 기억할 변수
		String newName = oldname;
		File file = new File(path, newName);
		while(file.exists()) {
			/*
				업로드한 파일의 이름이 이미 존재하는 경우
				이때는 파일이름을 변경해야 한다.
			 */
			cnt++;
			// .기준으로 앞의 내용과 뒤의 내용을 분리한다.
			int idx = oldname.lastIndexOf('.');
			String preStr = oldname.substring(0, idx);
			String extStr = oldname.substring(idx);
			preStr = preStr + "(" + cnt + ")";
			
			newName = preStr + extStr;
			file = new File(path, newName);
		}
		
		return newName;
	}
}