<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <form id="main">
		<object name="faxreceive" classid="method://huawei/Fax/ReceiveFax">
			<param name="FileName" value="Y:\fax\myreceive1.tif"/>
			<param name="TimeOut" value="180"/>
			<filled>
				<if cond="faxreceive=='SUCCESS'">
					<log>���ճɹ�</log>
				<elseif cond="faxreceive=='FAILURE'"/>
					<log>����ʧ��</log>
				<elseif cond="faxreceive=='USER_HOOK'"/>
					<log>�û��һ�</log>
				<elseif cond="faxreceive=='TIME_OUT'"/>
					<log>���ճ�ʱ</log>
				<elseif cond="faxreceive=='ERROR'"/>
					<log>���ش���</log>
				</if>
				<catch>
					<throw event="exit"/>
				</catch>
				
			</filled>
		</object>
    </form>
</vxml>
