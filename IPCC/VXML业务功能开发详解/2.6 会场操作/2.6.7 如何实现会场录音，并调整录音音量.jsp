<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
<script>
	function getFileName(){
		 var date = new Date();
		 var recordPath = "d:";
    	//¼���ļ���
   		 var recordName = date.getYear().toString()+
   		 (date.getMonth()+1).toString()+
   		 date.getDate().toString()+
   		 date.getUTCMilliseconds().toString()+".v3";
   		 
   		 recordName = recordPath +"/"+recordName;

   		 return recordName;
	}
</script>
	<form >
		<var name="curSSP"/>
		<var name="curConfNo"/>
		
		<!-- ��ȡ��ǰ����SSP -->
		<object name="getcurssp" classid="method://huawei/Other/GetCurSSP">
			<param name="SSP" expr="curSSP"/>
		</object>

		<var name="curConfNo"/>
		
		<!--�����᳡-->
		<object name="createconf" classid="method://huawei/Conf/CreateConf">
			<!-- �᳡�� -->
			<param name="ConfNO" expr="curConfNo"/>
			<!-- �᳡ͨ���� -->
            <param name="ChannelNum" expr="'2'"/>
             <!-- ������־,0��ʾ������,Ĭ��Ϊ0 -->
            <param name="CVFlag" expr="'0'"/>
            <filled>
            	<if cond="createconf=='SUCCESS'">
            		<clear namelist="startconfrecord joinconf rejustVolume"/>
            	<else/>
            		<exit/>
            	</if>
            </filled>
		</object>
		
		<!--�����᳡¼��-->
		<object name="startconfrecord" classid="method://huawei/Conf/ConfRecord" expr="true">
			<!-- �᳡�� -->
			<param name="ConfNO" expr="curConfNo"/>
			<!-- ¼����ʽ l 
				2��24K VOX
				4��64K Line PCM
				8��32K VOX
				16��Alaw PCM
				Ĭ��ֵΪ2�� -->
			<param name="RecordFormat" value ="2"/>
			<!-- ¼������ 
			 	1��IVR ָ���ļ���
				15��ҵ��ָ���ļ���
				Ĭ��ֵΪ1������ʹ��15��-->
			<param name="RecordType" value ="15"/>
			<!-- ¼��ģʽ 0��ʾ����,1��ʾ׷��,Ĭ��Ϊ0 -->
			<param name="RecordMode" value="0"/>
			<!-- ���¼��ʱ�� ��Ĭ��Ϊ30 �롣0 ��ʾ������¼����ֱ��ֹͣ¼���������·� -->
			<param name="MaxTime" value="0"/>
			<!-- ��"RecordType��=��1��ʱ����FileName��Ϊ�����������ʾƽ̨���ص�¼���ļ�����
				 ����RecordType��=��15��ʱ��FileName Ϊ�����������ʾ¼���ļ���ָ�����λ�á�
				 ��FileName��֧�ֵ���󳤶�Ϊ145 ���ֽ� -->
			<param name="FileName" expr="getFileName()"/>
			<param name="RecordBack" value="1"/>
		</object>
		

		
		<var name="channel1"/>
		<!--�û�����᳡-->
		<object name="joinconf" classid=" method://huawei/Conf/ConfAddUser" expr="true">
			<!-- �᳡�� -->
			<param name="ConfNO" expr="curConfNo"/>
			<!-- ���ӷ�SSP -->
			<param name="SrcSSP" expr="curSSP"/>
			<!-- ���ӷ����� 0��ʾ���з�,Ŀǰֻ֧������0 -->
			<param name="ConnPartyType" value="0"/>
			<!-- �����û��ڻ᳡�е�ͨ���� -->
			<param name="ChannelNO" expr="channel1"/>
		</object>
		
		<!-- �����᳡¼������ -->
		<object name="rejustVolume" classid="method://huawei/Conf/ConfRejustRecordVolume" expr="true">
			<!-- ��������������Ե���ֵ�����ڵ�����£�ƽ̨���������������ķ�ʽ���е��� -->
			<!-- �᳡�� -->
			<param name="ConfNO" expr="curConfNo"/>
			<!-- �᳡¼���������� �����Ļ᳡¼����������Ŀǰ֧�ֵķ�ΧΪ92 �� 107-->
			<param name="RecordVolume" expr="'102'"/>
			<!-- ��Ե���ֵ �������ӵ�ǰ¼���������������͵�ǰ¼��������Ĭ��ֵΪ0-->
			<param name="VolumeOffset" expr="'3'"/>
			<filled>
				<if cond="rejustVolume=='SUCCESS'">
					<log>���ڻ᳡¼�������ɹ�</log>
				<else/>
					<log>���ڻ᳡¼������ʧ��</log>
				</if>
			</filled>
		</object>

		<var name="outputinfo"/>
		<!-- �¼����� -->
		<object name="processEvent" classid="method://huawei/Other/ProcessEvent">
			<param name="OutputInfo" expr="outputinfo"/>
			<filled>
				<!-- �û��һ� -->
				<if cond="processEvent=='USER_HOOK'">
					<clear namelist="releaseCall stopconfrecord releaseConf"/>
				<else/>
					<clear namelist="processEvent"/>
				</if>
			</filled>
		</object>
		
		<object name="releaseCall" classid="method://huawei/Call/Disconnect" expr="true">
			<!-- �һ��ͷ� -->
			<param name="Cause" value="4"/>
			<param name="SSP" expr="curSSP"/>
		</object>
		
		<!-- ֹͣ�᳡¼�� -->
		<object name="stopconfrecord" classid=" method://huawei/Conf/ConfStopRecord" expr="true">
			<param name="ConfNO" expr="curConfNo"/>
		</object>
		
		<!-- �ͷŻ᳡ -->
		<object name="releaseConf" classid="method://huawei/Conf/ReleaseConf" expr="true">
			<param name="ConfNO" expr="curConfNo"/>
			<filled>
				<if cond="releaseConf=='SUCCESS'">
					<log>�ͷŻ᳡�ɹ�</log>
				</if>
			</filled>
		</object>
	</form>
	
</vxml>