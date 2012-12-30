<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
<!-- ����CCP���ݰ���IVR -->
    <form id="main">
    
	<var name="userName" expr="Object()"/>
	<var name="userpassword" expr="Object()"/>
	<var name="returnMsg" expr="Object()"/>
	<var name="msglen" expr="Object()"/>
	<var name="clearInfo" expr="Object()"/>
	<var name="param1" expr="Object()"/>
	
	<block>
		<assign name="userName.type" expr="'String'"/><!--��������-->
		<assign name="userName.value" expr="'1#df2#df3fsdf#1#'"/>
		<assign name="userName.size" expr="20"/>
	
		<assign name="userpassword.type" expr="'String'"/>
		<assign name="userpassword.value" expr="'1'"/>
		<assign name="userpassword.size" expr="20"/>
		
		<assign name="returnMsg.type" expr="'String'"/>
		<assign name="returnMsg.size" expr="20"/>
		
				
		<assign name="clearInfo.type" expr="'String'"/>
		<assign name="clearInfo.size" expr="50"/>
		<assign name="clearInfo.value" expr="''"/>
		
		<assign name="msglen.type" expr="'INT_2'"/>
		
		<assign name="param1.type" expr="'String'"/>
		<assign name="param1.size" expr="20"/>
		<assign name="param1.value" expr="'1#test#testtest#1#3'"/>
	</block>
	
	<var name="nPackLen" expr="0"/>
	<var name="nPackInfo" expr="0"/>
	<object name="Pack" classid="method://huawei/Other/Pack">
		<param name="PackLen" expr="nPackLen"/>
		<param name="paramname1" expr="userName"/>
		<param name="paramname2" expr="userpassword"/>
		<filled>
			<log>nPackLen:<value expr="nPackLen"/></log>
		</filled>
	</object>
	<!-- �����̷����׷��� -->
	<object name="sendCCP" classid="method://huawei/Extend/SendProxyMsg">
		<!--�Ƿ��׷���  0��ʾ��������1��ʾ�׷���-->
		<param name="FirstSendFlag" expr="1"/>
		<!--��ʾԶ��ͨѶ��������������õĶԶ�����ţ��������׷���ʱ��������д-->
		<param name="NetNumber" expr="1"/>	
		<!--��ʾԶ��ͨѶ���������õĶԶ������IVR ��ͻ��˵ķ������ţ��������׷���ʱ��������д-->
		<param name="RemoteIndex" expr="2"/>
		<!--�Զ˾�����������׷���ʱ��������д��
			�����ͺ�̰������׷�����ʱ����Ҫ��д�Զ˾��������
			һ������ʹ�õȴ�����<object>����ϵͳ�Զ���ֵ��������д�ĶԶ˾������  -->
		<param name="RemoteDsn" value="0"/>	
		<!-- ��ʾ��Ҫ���͵���Ϣ���ĳ��� -->
		<param name="MsgLen" expr="nPackLen"/>
		
		<!-- 
		һ����дʹ�����ݰ�object �������ʱ��ʾ���ݰ����Ǹ�������
		����ò���ȱʡ����ʾʹ��ϵͳ�������и�����Ϣ��
		�������Ӧ��
		<param name="MsgInfo" value="MsgInfo"/>
		 -->
		 <filled>
		 	<if cond="sendCCP=='FAILURE'">
		 		<exit/>
		 	<else/>
		 		<clear namelist="Pack2 waitproxymsg"/>
		 		<log>����CCP��Ϣ�ɹ�</log>
		 	</if>
		 </filled>
	</object>
	
	<!-- ��պ��и�����Ϣ -->
	<object name="Pack2" classid="method://huawei/Other/Pack" expr="true">
		<param name="PackLen" expr="nPackLen"/>
		<param name="paramname1" expr="clearInfo"/>
	</object>

	<var name="RemoteDsn1" expr="Object()"/>
	<var name="nMsgLen" expr="30"/>
	<object name="waitproxymsg" classid="method://huawei/Extend/WaitProxyMsg" expr="true">
		<param name="RemoteDsn" value="RemoteDsn1"/>
		<param name="TimeOut" value="6"/>
		<param name="MsgLen" expr="nMsgLen"/>
		<filled>
			<if cond="waitproxymsg=='SUCCESS'">
				<log>����CCP�ظ���Ϣ�ɹ� </log>
				<log>
					<value expr="RemoteDsn1.net"/>
			        <value expr="RemoteDsn1.id"/>
			        <value expr="RemoteDsn1.flag"/>
			        <value expr="RemoteDsn1.handle"/>
			        <value expr="RemoteDsn1.dsn"/>
			        <value expr="RemoteDsn1.reserved"/>
				</log>
				<clear namelist="Unpack"/>
			<else/>
				<clear namelist="waitproxymsg"/>
			</if>
		</filled>
	</object>
		
	<!--���-->
	<object name="Unpack" classid="method://huawei/Other/Unpack" expr="true">
		<param name="PackLen" expr="20"/>
		<!-- ��Ҫ���������ȣ��ĵ���û�ἰ -->
		<param name="parammsglen" expr="msglen"/>
		<param name="paramname1" expr="returnMsg"/>
		<filled>
			<if cond="Unpack=='SUCCESS'">
				<log>returnMsg��<value expr="returnMsg.value"/></log>
				<clear namelist="Pack3 sendcontinuemsg"/>
			<else/>
				<exit/>
			</if>
		</filled>
	</object>

	<!-- ����������������� -->
	<object name="Pack3" classid="method://huawei/Other/Pack" expr="true">
		<param name="PackLen" expr="nPackLen"/>
		<param name="paramname1" expr="param1"/>
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
