function checkImageType(fileName) {
	var pattern = /jpg$|gif$|png$|jpeg$/i;
	
	return fileName.match(pattern);
};

function getFileInfo(fullName) {
	var fileName, imgSrc, getLink;
	var fileLink;
	var bno = "${bVO.bno}";
	
	if (checkImageType(fullName)) {
		imgSrc = "/boards/" + bno + "/displayFile?fileName=" + fullName;
		fileLink = fullName.substr(14); // 원본파일명/2018/09/00/s_
		
		var front = fullName.substr(0, 12);
		var end = fullName.substr(14);
		
		getLink = "/boards/" + bno + "displayFile?fileName=" + front + end; // 원본파일보기용 URI
	} else {
		imgSrc = "/resources/dist/img/file.png";
		fileLink = fullName.substr(12); // 원본파일명/2018/09/00/
		getLink = "/boards/" + bno + "/displayFile?fileName=" + fullName;
	}
	
	fileName = fileLink.substr(fileLink.indexOf("_") + 1);
	
	return {fileName:fileName, imgSrc:imgSrc, getLink:getLink, fullName:fullName};
}