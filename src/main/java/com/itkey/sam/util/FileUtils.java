package com.itkey.sam.util;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.util.ObjectUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.itkey.sam.board.dto.FileDTO;

public class FileUtils {
	
	public List<FileDTO> parseFileInfo(MultipartHttpServletRequest mhsr) throws IOException {
		System.out.println("파일 업로드"+mhsr);
		if(ObjectUtils.isEmpty(mhsr)) {
			return null;
		}
		
		List<FileDTO> fileList = new ArrayList<FileDTO>();
		String root_path = mhsr.getSession().getServletContext().getRealPath("/");
		String attach_path = "resources\\images\\";
		System.out.println(root_path+","+attach_path);

		
		File file = new File(root_path + attach_path);
		// file.exists : 저장된 파일이 있는지 확인 
		if(file.exists() == false) {
			// mkdirs : 만들고자 하는 디렉토리의 상위 디렉토리가 존재하지 않을 경우, 상위 디렉토리까지 생성
			file.mkdirs();
		}
		
		// Iterator : 반복자. 읽어오는 방법 표준화.
		// 파일 이름을 읽어옴
		Iterator<String> iterator = mhsr.getFileNames();
		while(iterator.hasNext()) {
			System.out.println("파일이 있음");
			List<MultipartFile> list = mhsr.getFiles(iterator.next());
			// 파일 사이즈가 0보다 크다면 (업로드되었다면) 파일 주소를 조합해서 새로 만든후 file에 저장
			for(MultipartFile mf : list) {
				if(mf.getSize() > 0) {
					FileDTO boardFile = new FileDTO();
					boardFile.setFileOriginalName(mf.getOriginalFilename());
					boardFile.setFileChangedName(mf.getOriginalFilename()+mf.getSize());
					boardFile.setFilePath(root_path + attach_path);
					fileList.add(boardFile);
					
					file = new File(root_path + attach_path + mf.getOriginalFilename());
					mf.transferTo(file);
				} else {
					fileList = null;
				}
			}
		}
		return fileList;
	}
}
