<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <form id="main">
    	<!-- �ļ����� -->
		<object name="FileDownload" classid="method://huawei/Other/fileoperate">
			<param name="OperateType" value="1"/>
			<param name="FileType" expr="1"/>
			<param name="SrcFileName" value="http://10.166.102.154:8080/VXML/wait.wav"/>
			<param name="DesFileName" value="Y:\downloadWait.wav"/>
			<filled>
				<if cond="FileDownload=='SUCCESS'">
					<clear namelist="FileCheckExist"/>
				<else/>
					<exit/>
				</if>
			</filled>
		</object>
		
		<!-- �ļ��ж��Ƿ���� -->
		<object name="FileCheckExist" classid="method://huawei/Other/fileoperate" expr="true">
			<param name="OperateType" value="5"/>
			<param name="SrcFileName" value="Y:\downloadWait.wav"/>
			<filled>
				<if cond="FileCheckExist=='SUCCESS'">
					<clear namelist="FileReName FileDelete"/>
				<else/>
					<exit/>
				</if>
			</filled>
		</object>
		
		<!-- �ļ������� -->
		<object name="FileReName" classid="method://huawei/Other/fileoperate" expr="true">
			<param name="OperateType" value="3"/>
			<param name="SrcFileName" value="Y:\downloadWait.wav"/>
			<param name="DesFileName" value="Y:\newDownloadWait.wav"/>
		</object>
		
		<!-- �ļ�ɾ�� -->
		<object name="FileDelete" classid="method://huawei/Other/fileoperate" expr="true">
			<param name="OperateType" value="5"/>
			<param name="SrcFileName" value="Y:\newDownloadWait.wav"/>
		</object>
    </form>
</vxml>
