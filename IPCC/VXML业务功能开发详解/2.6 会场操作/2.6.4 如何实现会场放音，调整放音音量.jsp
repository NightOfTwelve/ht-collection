<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
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
            		<clear namelist="joinconf connectres"/>
            	<else/>
            		<exit/>
            	</if>
            </filled>
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

		<!-- �᳡�ű����� -->
		<object name="connectres" classid="method://huawei/Conf/ConfStartPlay" expr="true">
			<param name="ConfNO" expr="curConfNo"/>
			<param name="PlayPara" value="y:/wait.wav"/>
			<filled>
				<if cond="connectres=='SUCCESS'">
					<clear namelist="rejustVolume CollectCallee ProcessCollect"/>
				</if>
			</filled>
		</object>

		<!-- �Ի᳡�������������Ĵ�С���е��ڣ��᳡�û���˵����������Ӱ�� -->
		<object name="rejustVolume" classid="method://huawei/Conf/ConfRejustPlayVolume" expr="true">
			<!-- ��������������Ե���ֵ�����ڵ�����£�ƽ̨���������������ķ�ʽ���е��� -->
			<!-- �᳡�� -->
			<param name="ConfNO" expr="curConfNo"/>
			<!-- �᳡¼���������� �����Ļ᳡¼����������Ŀǰ֧�ֵķ�ΧΪ92 �� 107-->
			<param name="PlayVolume" expr="'102'"/>
			<!-- ��Ե���ֵ �������ӵ�ǰ¼���������������͵�ǰ¼��������Ĭ��ֵΪ0-->
			<param name="VolumeOffset" expr="'3'"/>
			<filled>
				<if cond="rejustVolume=='SUCCESS'">
					<log>���ڻ᳡���������ɹ�</log>
				<else/>
					<log>���ڻ᳡���������ɹ�</log>
				</if>
			</filled>
		</object>
				
		<!-- �᳡ͨ���պ� -->
		<object name="CollectCallee" classid="method://huawei/Conf/CollectDigit" expr="true">
            <param name="ConfNO"   expr="curConfNo"/>
            <param name="ChannelNO" expr="channel1"/>
            <filled>
                <if cond="CollectCallee == 'SUCCESS'">
                    <clear namelist="ProcessCollect"/>
                </if>
            </filled>
        </object>    
        
        <!-- �պ��¼��ȴ����� -->
       <var name="outputinfo"/>
       <object name="ProcessCollect" classid="method://huawei/Other/ProcessEvent" expr="true">
            <param name="OutputInfo"    expr="outputinfo"/>
            <filled>
            	<if cond="ProcessCollect=='CP_USERDIALING'">
            		<log>ͨ���պ�ֵΪ:<value expr="outputinfo"/></log>
            		 <if cond ="outputinfo=='1'">
            		 	<clear namelist="stopcollectdigit stopPlay"/>
            		 <else/>
            		 	<clear namelist="CollectCallee ProcessCollect"/>
            		 </if>
            	<elseif cond="ProcessCollect=='CP_PLAYEND'"/>
            		<log>�᳡��������</log>
            		<goto nextitem="processEvent"/>
            	</if>
            </filled>
       </object>
       <!-- ֹͣ�պ� -->
		<object name="stopcollectdigit" classid=" method://huawei/Conf/StopCollectDigit" expr="true">
		<param name="ConfNO" expr="curConfNo"/>
		<param name="ChannelNO" expr="channel1"/>
		</object>
		
		<!-- ֹͣ���� -->
       <object name="stopPlay" classid="method://huawei/Conf/ConfStopPlay" expr="true">
			<param name="ConfNO" expr="curConfNo"/>
		</object>

		<!-- �¼����� -->
		<object name="processEvent" classid="method://huawei/Other/ProcessEvent">
			<param name="OutputInfo" expr="outputinfo"/>
			<filled>
				<!-- �û��һ� -->
				<if cond="processEvent=='USER_HOOK'">
					<clear namelist="releaseCall releaseConf"/>
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