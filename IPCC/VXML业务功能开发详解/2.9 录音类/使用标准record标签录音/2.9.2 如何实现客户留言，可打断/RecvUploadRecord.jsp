<%@ page language="java" import="com.huawei.fileUpload.*"%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.Date"%>

<%
	com.huawei.fileUpload.upBean faxUpload = new com.huawei.fileUpload.upBean();
	// upBean faxUpload = new upBean();
	faxUpload.initialize(pageContext);
	faxUpload.setAllowedExtList("tif,txt,wav");
	faxUpload.setIsCover(true);
	String[] sourceName = null;
	String myName=new String("");	
	String	sFPShareDir = "F:\\work\\VXML\\upload\\wikiwiki";
	faxUpload.setRealPath(sFPShareDir);

	try
	{
		//���������ݵ�����������ݽṹ��
		faxUpload.upload();
	}
	catch(Exception e)
	{
		throw e;
	}
	
	// ��ȡҳ���ϵĶ������

	try
	{
		//�õ������ϴ����ļ�
		files myFiles = faxUpload.getFiles();

		if( myFiles != null )
		{
			int	iFileCount = myFiles.getCount();
			System.out.println(iFileCount);
			sourceName = new String[iFileCount];
			Date	CurrentDate = new Date();
			Long	lCurrentTime = new Long( CurrentDate.getTime() );
			//���ļ����浽������
			for(int i = 0; i < iFileCount; i++)
			{
				
				myName = lCurrentTime.toString();
				myName = myName + "_" + i+ "."+myFiles.getFile(i).getExtName();
				sourceName[i]=myFiles.getFile(i).getName();
				myFiles.getFile(i).setName(myName);
				//�����ֱ��淽����һ���Ǳ�����faxUpload.setRealPath()���趨·���У�ʹ��saveAs()��һ�������Ᵽ�浽�����ļ���,ʹ��.saveAs(String realPath)
				myFiles.getFile(i).saveAs();
			}
		} 
	}
	catch (	Exception e) 
	{
		throw e;
	}
	if( myName != null && !myName.equals("") )
	{
		System.out.println(myName);
%>
<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form>
		<var name="FileName"/>
		<block>
			<assign name="FileName" expr="'<%=myName%>'"/>
			<submit next="playrecord.jsp" namelist="FileName"/>
		</block>
	</form>
</vxml>
<%
}
%>