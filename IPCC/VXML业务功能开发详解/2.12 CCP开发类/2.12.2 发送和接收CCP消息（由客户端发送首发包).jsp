<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form>
		<!-- ���������̽���CCP�ͻ��˵����ݰ� -->
		
		<!-- 1����ʼ��Obj���������ڽ���CCP���͹����Ĳ���-->
		<var name="opponent_net" expr="Object()"/>
		<var name="opponent_id" expr="Object()"/>
		<var name="opponent_flag" expr="Object()"/>
		<var name="sender_handle" expr="Object()"/>
		<var name="sender_dsn" expr="Object()"/>
		<var name="reserved" expr="Object()"/>
		<var name="param2" expr="Object()"/><!-- ����С -->
		<var name="param3" expr="Object()"/><!-- ������ -->
		<var name="RemoteDsn1" expr="Object()"/><!-- �Զ˱�ʾ -->
		<var name="backParam" expr="Object()"/><!-- �Զ˱�ʾ -->
		<block>
			<assign name="opponent_net.type" expr="'INT_1'"/> 
			<assign name="opponent_id.type" expr="'INT_2'"/>
			<assign name="opponent_flag.type" expr="'INT_1'"/>
			<assign name="sender_handle.type" expr="'INT_1'"/>
			<assign name="sender_dsn.type" expr="'INT_2'"/>
			<assign name="reserved.type" expr="'INT_1'"/>			
			<assign name="param2.type" expr="'INT_2'"/>
			<assign name="param3.type" expr="'String'"/>
			<assign name="param3.size" expr="100"/>
			<assign name="backParam.type" expr="'String'"/>
			<assign name="backParam.size" expr="100"/>
			<assign name="backParam.value" expr="'1#123#456#1#2'"/>
		</block>		

		<object name="Unpack" classid="method://huawei/Other/Unpack">	
			<param name="paramname1" expr="opponent_net"/>
			<param name="paramname2" expr="opponent_id"/>
			<param name="paramname3" expr="opponent_flag"/>
			<param name="paramname4" expr="sender_handle"/>
			<param name="paramname5" expr="sender_dsn"/>
			<param name="paramname6" expr="reserved"/>
			<param name="paramname7" expr="param2"/>
			<param name="paramname8" expr="param3"/>
			<filled>
				<if cond="Unpack=='SUCCESS'">
					<clear namelist="Pack3 sendcontinuemsg"/>
				</if>
			</filled>
		</object>
		<block>
			<assign name="RemoteDsn1.net" expr="opponent_net.value"/>   
			<assign name="RemoteDsn1.id" expr="opponent_id.value"/>
			<assign name="RemoteDsn1.flag" expr="opponent_flag.value"/>
			<assign name="RemoteDsn1.handle" expr="sender_handle.value"/>
			<assign name="RemoteDsn1.dsn" expr="sender_dsn.value"/>
			<assign name="RemoteDsn1.reserved" expr="reserved.value"/>
		</block>
		
		<var name="nMsgLen" expr="30"/>
		<!-- ����������������� -->
		<object name="Pack3" classid="method://huawei/Other/Pack" expr="true">
			<param name="PackLen" expr="nPackLen"/>
			<param name="paramname1" expr="backParam"/>
		</object>
		
		<!-- ����CCP ������ -->
		<object name="sendcontinuemsg" classid="method://huawei/Extend/SendProxyMsg" expr="true">
			<param name="FirstSendFlag" value="0"/>
			<param name="RemoteDsn" value="RemoteDsn1"/>
			<param name="MsgLen" expr="nMsgLen"/>
			<filled>
				<if cond="sendcontinuemsg=='SUCCESS'">
					<log>���������ͳɹ�</log>
				</if>
			</filled>
		</object>
	</form>
</vxml>
